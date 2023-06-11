report 50295 "BOM Vs Actual (Final)"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\BOMVsActualFinal.rdlc';

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    dataitem(ItemAmount1; "Item Amount")
                    {
                    }
                    dataitem(ItemAmount2; "Item Amount")
                    {
                    }
                    dataitem(ItemAmount3; "Item Amount")
                    {
                    }
                }
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

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        Rowno: Integer;
        tgWin: Dialog;
        tgItem: Record Item;
        RecIle: Record "Item Ledger Entry";
        Costactual: Decimal;
        tgRemainigQuantityCost: Decimal;
        RecItemAmount: Record "Item Amount";
        "SFGItemNo.": Code[20];
        I: Integer;
        CompLine: Integer;
        "ProdNo.": Code[20];
        "ProdLineNo.": Integer;
        TestTgItem: Record Item;
        ProdOrLine: Record "Prod. Order Line";
        Finishedqty: Decimal;
        SFGQty: Decimal;
        ExpQty: Decimal;
        RimQty: Decimal;
        ExpCost: Decimal;
        Concost: Decimal;
        FinishedCost: Decimal;
        RimCost: Decimal;
        J: Integer;
        Comm: Decimal;
        Eco: Decimal;
        Broken: Decimal;
        recProdOrder: Record "Production Order";
        recProdOrderLine: Record "Prod. Order Line";
        recprodbom: Record "Production BOM Line";
        var1: Decimal;
        var2: Decimal;
        var3: Code[1000];
        x: Integer;
        recprodbom2: Record "Production BOM Header";
        Prodbomline2: Record "Production BOM Line";
        itemamt2: Record "Item Amount";
        var5: Decimal;
        var6: Decimal;
        recprodcomponent: Record "Prod. Order Component";
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text001: Label 'Production Order No #1#############################\';
        TEXT002: Label 'SFG No.             #2#############################\';
        TEXT003: Label 'RM No.              #3#############################';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'Filters';
        Text011: Label 'Period Filter';

    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[500]; Bold: Boolean; UnderLine: Boolean)
    begin
        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Row No.", RowNo);
        ExcelBuffer.VALIDATE("Column No.", ColumnNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer.Bold := Bold;
        ExcelBuffer.Underline := UnderLine;
        ExcelBuffer.INSERT;
    end;

    procedure UpdateSFGRecur("ItemNo.": Code[20]; MainOrderComp: Record "Prod. Order Component")
    var
        ILE: Record "Item Ledger Entry";
        ProdOrderComp: Record "Prod. Order Component";
        RecItem: Record Item;
        CopyProdOrderComp: Record "Prod. Order Component";
    begin
        ILE.RESET;
        ILE.SETCURRENTKEY("Item No.", "Location Code", "Entry Type", "Posting Date");
        ILE.SETRANGE("Item No.", "ItemNo.");
        ILE.SETFILTER(ILE."Entry Type", '%1', ILE."Entry Type"::Output);
        IF ILE.FIND('+') THEN BEGIN
            ProdOrderComp.RESET;
            ProdOrderComp.SETFILTER(Status, '%1|%2', ProdOrderComp.Status::Released, ProdOrderComp.Status::Finished);
            ProdOrderComp.SETRANGE("Prod. Order No.", ILE."Order No.");
            ProdOrderComp.SETRANGE("Prod. Order Line No.", ILE."Order Line No.");
            ProdOrderComp.SETFILTER("Item No.", '<>%1', '');
            IF ProdOrderComp.FIND('-') THEN
                //REPEAT
                RecItem.GET(ProdOrderComp."Item No.");
            IF COPYSTR(RecItem."Inventory Posting Group", 1, 3) = 'WIP' THEN BEGIN
                IF ProdOrLine.GET(ProdOrderComp.Status, ProdOrderComp."Prod. Order No.", ProdOrderComp."Prod. Order Line No.") THEN
                    tgWin.UPDATE(2, ProdOrLine."Item No.");
                "SFGItemNo." := ProdOrLine."Item No.";
                CLEAR(CopyProdOrderComp);
                CopyProdOrderComp := ProdOrderComp;
                InsertItemLine(CopyProdOrderComp, ProdOrLine, MainOrderComp);
                IF ProdOrderComp."Original Component" = TRUE THEN
                    UpdateSFGRecur(RecItem."No.", ProdOrderComp);
            END ELSE BEGIN
                IF ProdOrLine.GET(ProdOrderComp.Status, ProdOrderComp."Prod. Order No.", ProdOrderComp."Prod. Order Line No.") THEN
                    "SFGItemNo." := ProdOrLine."Item No.";
                CLEAR(CopyProdOrderComp);
                CopyProdOrderComp := ProdOrderComp;
                InsertItemLine(CopyProdOrderComp, ProdOrLine, MainOrderComp);
            END;
            //UNTIL ProdOrderComp.NEXT = 0;
        END;
    end;

    procedure InsertItemLine(ProdComp: Record "Prod. Order Component"; RecPodOrderLine: Record "Prod. Order Line"; RecMainProdComp: Record "Prod. Order Component")
    var
        RecItemAmount: Record "Item Amount";
        TestItem: Record Item;
    begin
        RecItemAmount.INIT;
        RecItemAmount."Item No." := "SFGItemNo.";
        RecItemAmount."RM Item No." := ProdComp."Item No.";
        tgWin.UPDATE(3, ProdComp."Item No.");
        TestItem.GET(ProdComp."Item No.");
        IF FinishedCost <> 0 THEN
            RecItemAmount.Amount := J + 1;
        RecItemAmount."Amount 2" := I + 1;
        RecItemAmount."Inventory Posting Group" := TestItem."Inventory Posting Group";
        RecItemAmount."Entry Type" := RecItemAmount."Entry Type"::Consumption;
        RecItemAmount."Production Order No." := "ProdNo.";
        RecItemAmount."Comp Line No." := CompLine;
        RecItemAmount."Prod. Order Line No." := "ProdLineNo.";
        IF RecPodOrderLine."Finished Quantity" <> 0 THEN BEGIN
            RecItemAmount."Expected Quantity" := (ProdComp."Expected Qty. (Base)" / RecPodOrderLine."Finished Qty. (Base)") *
            RecMainProdComp."Expected Quantity";
            RecItemAmount."Remaining Quantity" := (ProdComp."Remaining Qty. (Base)" / RecPodOrderLine."Finished Qty. (Base)") *
            RecMainProdComp."Remaining Quantity";
        END ELSE BEGIN
            RecItemAmount."Expected Quantity" := 0;
            RecItemAmount."Remaining Quantity" := 0;
        END;
        RecItemAmount.Quantity := (RecItemAmount."Expected Quantity" - RecItemAmount."Remaining Quantity");
        RecItemAmount."Due Date" := ProdComp."Due Date";
        RecItemAmount."Location Code" := ProdComp."Location Code";
        J += 1;
        I += 1;
        RecItemAmount.INSERT;
    end;

    procedure MakeExcelInfo()
    begin
        /*ExcelBuffer.SetUseInfoSheed;
        ExcelBuffer.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuffer.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuffer.NewRow;
        ExcelBuffer.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuffer.AddInfoColumn(FORMAT(Text001),FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuffer.NewRow;
        ExcelBuffer.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuffer.AddInfoColumn(REPORT::"BOM Actual Vs Standard",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuffer.NewRow;
        ExcelBuffer.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuffer.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuffer.NewRow;
        ExcelBuffer.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuffer.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuffer.NewRow;
        
        ExcelBuffer.AddInfoColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuffer.AddInfoColumn("Production Order".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        {
        ExcelBuf.NewRow;
        
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(RecIle.GETFILTER("Date Filter"),FALSE,'',FALSE,FALSE,FALSE,'');
        }
        ExcelBuffer.ClearNewRow;
        //MakeExcelDataHeader;
         */

    end;
}

