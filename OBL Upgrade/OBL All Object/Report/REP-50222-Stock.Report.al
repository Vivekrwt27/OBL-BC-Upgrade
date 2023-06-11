report 50222 Stock
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\Stock.rdl';

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Cost Amount (Actual)", "Cost Amount (Expected)", "Inventory Posting Group";
                DataItemLink = "Location Code" = FIELD(Code);
                DataItemTableView = SORTING("External Transfer", "InTransit", "Plant Code", "Entry Type", "Posting Date", "Qty in Sq.Mt.", "Document Type", "Relational Location Code", "Category Code")
                                    WHERE("External Transfer" = FILTER(false),
                                          InTransit = FILTER(false),
                                          "Re Process Production Order" = FILTER(false));
                RequestFilterFields = "Posting Date", "Item Category Code";
                column(Filters; Filters)
                {
                }
                column(ILE_ItemNo; "Item Ledger Entry"."Item No.")
                {
                }
                column(ILE_LocationCode; "Item Ledger Entry"."Location Code")
                {
                }
                column(Desc; Desc)
                {
                }
                column(Desc2; Desc2)
                {
                }
                column(ILE_ItemCategoryCode; "Item Ledger Entry"."Item Category Code")
                {
                }
                column(ILE_InventoryPostinggroup; "Item Ledger Entry"."Inventory Posting Group")
                {
                }
                column(ILE_UMC; "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                column(Opn; Opn)
                {
                }
                column(OPnVal; OPnVal)
                {
                }
                column(ProductionQty; ProductionQty)
                {
                }
                column(ProdVal; ProdVal)
                {
                }
                column(TransferIn; TransferIn)
                {
                }
                column(TransferInVal; TransferInVal)
                {
                }
                column(TransferOut; TransferOut)
                {
                }
                column(TransferOutVal; TransferOutVal)
                {
                }
                column(ConsumptionQty; ConsumptionQty)
                {
                }
                column(ConsVal; ConsVal)
                {
                }
                column(AdjustQty; AdjustQty)
                {
                }
                column(AdjustVal; AdjustVal)
                {
                }
                column(Closing; Closing)
                {
                }
                column(ClosingVal; ClosingVal)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    j += 1;
                    tgWin.UPDATE(1, ROUND(j / i * 10000, 1));

                    IF "Entry Type" = "Entry Type"::Consumption THEN BEGIN
                        ConsumptionQty := Quantity;
                        ConsVal := "Cost Amount (Expected)" + "Cost Amount (Actual)";
                    END;

                    IF "Entry Type" = "Entry Type"::Output THEN BEGIN
                        ProductionQty := Quantity;
                        ProdVal := "Cost Amount (Expected)" + "Cost Amount (Actual)";
                    END;

                    IF "Entry Type" = "Entry Type"::Transfer THEN BEGIN
                        IF Quantity < 0 THEN BEGIN
                            TransferOut := Quantity;
                            TransferOutVal := "Cost Amount (Expected)" + "Cost Amount (Actual)";
                        END ELSE BEGIN
                            TransferIn := Quantity;
                            TransferInVal := "Cost Amount (Expected)" + "Cost Amount (Actual)";
                        END;
                    END;

                    IF "Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt."] THEN BEGIN
                        AdjustQty := Quantity;
                        AdjustVal := "Cost Amount (Expected)" + "Cost Amount (Actual)";
                    END;


                    //CurrReport.SHOWOUTPUT(CurrReport.TOTALSCAUSEDBY=FIELDNO("Item No."));

                    //IF CurrReport.SHOWOUTPUT THEN BEGIN
                    Opn := 0;
                    Closing := 0;
                    OPnVal := 0;
                    ClosingVal := 0;
                    Desc := '';
                    Desc2 := '';
                    IF recItem.GET("Item No.") THEN BEGIN
                        Desc := recItem.Description;
                        Desc2 := recItem."Description 2";
                    END;
                    IF FromDate <> 0D THEN BEGIN
                        recILE.RESET;
                        recILE.SETCURRENTKEY("Posting Date", "Item No.");
                        recILE.SETFILTER("Posting Date", '<%1', FromDate);
                        recILE.SETRANGE("Item No.", "Item No.");
                        recILE.SETRANGE("Location Code", Location.Code);
                        IF recILE.FINDFIRST THEN
                            REPEAT
                                recILE.CALCFIELDS(recILE."Cost Amount (Expected)", recILE."Cost Amount (Actual)");
                                Opn += recILE.Quantity;
                                OPnVal += recILE."Cost Amount (Expected)" + recILE."Cost Amount (Actual)";
                            UNTIL recILE.NEXT = 0;
                    END;
                    recILE.RESET;
                    recILE.SETCURRENTKEY("Posting Date", "Item No.");
                    recILE.SETRANGE("Posting Date", 0D, Enddate);
                    recILE.SETRANGE("Item No.", "Item No.");
                    recILE.SETRANGE("Location Code", Location.Code);
                    IF recILE.FIND('-') THEN
                        REPEAT
                            recILE.CALCFIELDS(recILE."Cost Amount (Expected)", recILE."Cost Amount (Actual)");
                            Closing += recILE.Quantity;
                            ClosingVal += recILE."Cost Amount (Expected)" + recILE."Cost Amount (Actual)";
                        UNTIL recILE.NEXT = 0;
                    //MESSAGE('%1',ClosingVal);
                    /*
                    Closing :=Opn+ProductionQty-ConsumptionQty+TransferIn-TransferOut;
                    ClosingVal := OPnVal+ProdVal-ConsVal+TransferInVal+TransferOutVal;
                    */

                    MakeExcelDataBody;

                    //END;

                end;

                trigger OnPreDataItem()
                begin

                    CurrReport.CREATETOTALS(ProductionQty, ConsumptionQty, TransferIn, TransferOut, ProdVal, ConsVal, TransferInVal, TransferOutVal, AdjustQty
                                            , AdjustVal);
                    i := COUNT;
                    Filters := "Item Ledger Entry".GETFILTERS();
                    "Item Ledger Entry".SETRANGE("Posting Date", FromDate, Enddate);
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

        tgWin.CLOSE;
    end;

    trigger OnPreReport()
    begin

        MakeExcelInfo;
        IF "Item Ledger Entry".GETFILTER("Posting Date") <> '' THEN BEGIN
            FromDate := "Item Ledger Entry".GETRANGEMIN("Posting Date");
            Enddate := "Item Ledger Entry".GETRANGEMAX("Posting Date");
        END ELSE BEGIN
            FromDate := 0D;
            Enddate := TODAY;
        END;
        IF FromDate = Enddate THEN
            FromDate := 0D;

        tgWin.OPEN(tgText001);
    end;

    var
        recItem: Record Item;
        Desc: Text[100];
        Desc2: Text[100];
        recILE: Record "Item Ledger Entry";
        ExcelBuf: Record "Excel Buffer" temporary;
        Opn: Decimal;
        ProductionQty: Decimal;
        ConsumptionQty: Decimal;
        TransferIn: Decimal;
        TransferOut: Decimal;
        Closing: Decimal;
        FromDate: Date;
        OPnVal: Decimal;
        ProdVal: Decimal;
        ConsVal: Decimal;
        TransferInVal: Decimal;
        TransferOutVal: Decimal;
        ClosingVal: Decimal;
        Enddate: Date;
        tgWin: Dialog;
        i: Decimal;
        j: Decimal;
        AdjustQty: Decimal;
        AdjustVal: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text001: Label 'Stock';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'Filters';
        Text011: Label 'Period Filter';
        tgText001: Label 'Process @1@@@@@@@@@@@@@@@@@@@@';
        Filters: Text[100];


    procedure MakeExcelInfo()
    begin
        /*ExcelBuf.SetUseInfoSheed;  //6823
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(FORMAT(Text001),FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::Stock,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        
        ExcelBuf.AddInfoColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(Location.GETFILTERS+' '+"Item Ledger Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');  *///TMC::6823
        /*
        ExcelBuf.NewRow;
        
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Item Ledger Entry".GETFILTER("Date Filter"),FALSE,'',FALSE,FALSE,FALSE,'');
        */
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;

    end;

    local procedure MakeExcelDataHeader()
    begin
        /*ExcelBuf.AddColumn('Location',FALSE,'',TRUE,FALSE,TRUE,'');
        //ExcelBuf.AddColumn('RPO Doc No',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Item Code',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Item Desc-1',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Item Desc-2',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Item Category Code',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Inventory Posting Group',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('UOM',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Opening Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Opening Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Production Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Production Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Transfer In Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Transfer In Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Transfer Out Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Transfer Out Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Consumption Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Consumption Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Adjustment Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Adjustment Value',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Closing Qty',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Closing Value',FALSE,'',TRUE,FALSE,TRUE,'');
        */

    end;


    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        /*ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',TRUE,FALSE,TRUE,'');
        //ExcelBuf.AddColumn("Item Ledger Entry"."Document No.",FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn("Item Ledger Entry"."Item No.",FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Desc,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Desc2,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn("Item Ledger Entry"."Item Category Code",FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn("Item Ledger Entry"."Inventory Posting Group",FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn("Item Ledger Entry"."Unit of Measure Code",FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Opn,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(OPnVal,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ProductionQty,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ProdVal,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(TransferIn,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(TransferInVal,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(TransferOut,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(TransferOutVal,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ConsumptionQty,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ConsVal,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(AdjustQty,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(AdjustVal,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Closing,FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ClosingVal,FALSE,'',TRUE,FALSE,TRUE,'');
         */

    end;


    procedure CreateExcelbook()
    begin
        /*ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text002,Text001,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');  */

    end;
}

