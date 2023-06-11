report 50003 "Indent Summary/Pending Indents"
{
    //  Report 48 - P3 ravi
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\IndentSummaryPendingIndents.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Indent Line"; 50017)
        {
            CalcFields = Lrate, "Vendor Name";
            DataItemTableView = SORTING("Product Group Code")
                                ORDER(Ascending)
                                WHERE(Status = CONST(Authorized),
                                      Deleted = CONST(false));
            RequestFilterFields = Date;
            column(IndentType; IndentType)
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(Sno; "SNo.")
            {
            }
            column(DocNo; "Indent Line"."Document No.")
            {
            }
            column(DAte; FORMAT("Indent Line".Date))
            {
            }
            column(AuthDate; FORMAT(IndentHeader."Authorization Date"))
            {
            }
            column(No; "Indent Line"."No.")
            {
            }
            column(Decs; "Indent Line".Description + "Indent Line"."Description 2")
            {
            }
            column(UOM; "Indent Line"."Unit of Measurement")
            {
            }
            column(DeptPlant; "Dept/Plant")
            {
            }
            column(Plant; plant)
            {
            }
            column(Qty; "Indent Line".Quantity)
            {
            }
            column(Stock; Stock)
            {
            }
            column(consumption; consumption)
            {
            }
            column(OrderNo; "Indent Line"."Order No.")
            {
            }
            column(LastOrderNo; "Indent Line"."Last Order No.")
            {
            }
            column(purpose; purpose)
            {
            }
            column(LastDate; FORMAT("Indent Line"."Last Order Date"))
            {
            }
            column(ProductGroupCode_IndentLine; "Indent Line"."Product Group Code")
            {
            }
            column(ProductGroupDesc; ProductGroupDesc)
            {
            }
            column(Lrate; "Indent Line".Lrate)
            {
            }
            column(LastVendorName; "Indent Line"."Vendor Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "SNo." := "SNo." + 1;
                Stock := 0;
                consumption := 0;
                //IndentHeader.SETRANGE(IndentHeader."No.","Document No.");
                //IF IndentHeader.FIND('-') THEN
                IF IndentHeader.GET("Indent Line"."Document No.") THEN
                    purpose := IndentHeader.Description;
                //Ori UT
                Dim.SETFILTER(Dim."Dimension Code", '%1', 'PLANT');
                Dim.SETRANGE(Dim.Code, IndentHeader."Plant Code");
                IF Dim.FIND('-') THEN
                    Desc := Dim.Name;
                "Dept/Plant" := IndentHeader."Department Code";
                plant := Desc;

                //Ori UT
                IF "No." <> '' THEN BEGIN
                    Item.RESET;
                    Item.SETRANGE(Item."No.", "No.");
                    Item.SETFILTER(Item."Location Filter", '%1', "Indent Line"."Location Code");
                    IF Item.FIND('-') THEN BEGIN
                        Item.CALCFIELDS(Item."Net Change");
                        Stock := Item."Net Change";
                    END;

                    ILE.RESET;
                    ILE.SETRANGE(ILE."Item No.", "No.");
                    ILE.SETFILTER(ILE."Location Code", '%1', "Indent Line"."Location Code");
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
                    IF "Indent Line".Date <> 0D THEN BEGIN
                        ILE.SETRANGE(ILE."Posting Date", CALCDATE('-4M', "Indent Line".Date), "Indent Line".Date);
                        IF (DATE2DMY("Indent Line".Date, 2) < 4) OR (DATE2DMY("Indent Line".Date, 2) >= 8) THEN
                            ILE.SETRANGE(ILE."Posting Date", CALCDATE('-4M', "Indent Line".Date), "Indent Line".Date)
                        ELSE
                            IF (DATE2DMY("Indent Line".Date, 2) >= 4) AND (DATE2DMY("Indent Line".Date, 2) < 8) THEN
                                ILE.SETRANGE(ILE."Posting Date", DMY2DATE(1, 4, DATE2DMY("Indent Line".Date, 3)), "Indent Line".Date);

                        IF ILE.FIND('-') THEN
                            REPEAT
                                consumption += ABS(ILE.Quantity);
                            UNTIL ILE.NEXT = 0;
                    END;
                END;


                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";

                //CurrReport.SHOWOUTPUT(CurrReport.PAGENO = 1);      //6823


                //CurrReport.SHOWOUTPUT(CurrReport.PAGENO > 1);     //6823
                /*  //6823
                IF printtoexcel THEN BEGIN
                   ExcelBuf.AddColumn('Product Group.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('S No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Indent No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Indent Date',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Indent Auth. Date',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Item Code',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Item Desc',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('UOM',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Dept/Plant',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Total Value',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Qty. Required',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Present Stock',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Consumption in Last 4 Month',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Last PO No.',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Last PO Date',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Deptt./Purpose',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Last Purchase Rate',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('Last Purchase Vendor Name',FALSE,'',TRUE,FALSE,FALSE,'');
                
                   ExcelBuf.NewRow;
                END;
                */

                /*
                ProductGroup.RESET;
                ProductGroup.SETRANGE(ProductGroup.Code,"Product Group Code");
                IF ProductGroup.FIND('-') THEN
                  ProductGroupDesc := ProductGroup.Description
                ELSE
                  ProductGroupDesc := '';
                */
                //
                //  ProductGroup.RESET;
                //ProductGroup.SETRANGE(ProductGroup.Code, "Product Group Code");
                //IF ProductGroup.FIND('-') THEN
                //  ProductGroupDesc := ProductGroup.Description
                //ELSE
                //  ProductGroupDesc := '';
                //
                /* //6823
                
                
                IF printtoexcel THEN BEGIN
                   ExcelBuf.AddColumn(ProductGroupDesc,FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("SNo.",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("Document No.",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(Date,FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(IndentHeader."Authorization Date",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("No.",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(Description+' '+"Description 2",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("Unit of Measurement",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("Dept/Plant",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(Quantity,FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(Stock,FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(consumption,FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("Last Order No.",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn("Last Order Date",FALSE,'',TRUE,FALSE,FALSE,'');
                   ExcelBuf.AddColumn(purpose,FALSE,'',TRUE,FALSE,FALSE,'');
                   CALCFIELDS(Lrate);
                   ExcelBuf.AddColumn(Lrate,FALSE,'',TRUE,FALSE,FALSE,'');
                   CALCFIELDS("Vendor Name");
                   ExcelBuf.AddColumn("Vendor Name",FALSE,'',TRUE,FALSE,FALSE,'');
                
                
                   ExcelBuf.NewRow;
                END;
                
                
                */

            end;

            trigger OnPreDataItem()
            begin

                IF IndentType = IndentType::"Pending Indents" THEN
                    SETRANGE("Order No.", '');

                IF IndentSeries <> '' THEN
                    "Indent Line".SETFILTER("Document No.", IndentSeries);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field("Indent Type"; IndentType)
                    {
                        ApplicationArea = All;
                    }
                    field("Indent No Series"; IndentSeries)
                    {
                        ApplicationArea = All;
                    }
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
        "SNo." := 0
    end;

    trigger OnPostReport()
    begin
        IF printtoexcel THEN
            CreateExcelbook;

        //RepAuditMgt.CreateAudit(50003)
    end;

    var
        "SNo.": Integer;
        IndentHeader: Record "Indent Header";
        purpose: Text[100];
        ILE: Record "Item Ledger Entry";
        Item: Record Item;
        Stock: Decimal;
        consumption: Decimal;
        IndentType: Option "All Indents","Pending Indents";
        //ProductGroup: Record "Product Group";
        ProductGroupDesc: Text[30];
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        Comment: Record "Comment Line";
        "Dept/Plant": Text[100];
        plant: Text[100];
        Dim: Record "Dimension Value";
        Desc: Text[100];
        CompanyName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ExcelBuf: Record "Excel Buffer" temporary;
        printtoexcel: Boolean;
        IndentSeries: Code[30];

    procedure MakeExcelInfo()
    begin

        /*      //TMC::6823
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn('Indent Summary',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::"Dispatch Plan1",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Indent Line".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
    end;

    procedure CreateExcelbook()
    begin

        /*  //TMC::6823
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text002,Text001,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;
}

