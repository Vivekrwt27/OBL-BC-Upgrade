report 50026 "Item Stock by Location"
{
    // 
    // TRIRJ ORIENT2.01 04-12-08:Created New report for Location wise Item Stock
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ItemStockbyLocation.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            CalcFields = "Cost Amount (Actual)";
            DataItemTableView = SORTING("Location Code", "Item No.", "Variant Code", Open, Positive, "Posting Date");
            RequestFilterFields = "Posting Date", "Item No.", "Location Code";
            column(Code_Location; Location1.Code)
            {
            }
            column(Name_Location; Location1.Name)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(Description; RecItm.Description + RecItm."Description 2")
            {
            }
            column(BaseUnitMeasurement; RecItm."Base Unit of Measure")
            {
            }
            column(NetChange; NetChange)
            {
            }
            column(QtySqm; QtySqm)
            {
            }
            column(CostAmtActual; CostAmtActual)
            {
            }
            column(UnitCost; RecItm."Unit Cost")
            {
            }
            column(LastDirectCost; RecItm."Last Direct Cost")
            {
            }
            column(BP; BP)
            {
            }
            column(MRP; MRP)
            {
            }
            column(Wt; Wt)
            {
            }
            column(targetLocation; targetLocation)
            {
            }
            column(ItemGrossWeight; RecItm."Gross Weight")
            {
            }
            column(NetWeight; RecItm."Net Weight")
            {
            }
            column(InvPostingGrp; RecItm."Inventory Posting Group")
            {
            }
            column(ItemCatCode; RecItm."Item Category Code")
            {
            }
            column(ItemClassification; RecItm."Item Classification")
            {
            }
            column(PlantCod; RecItm."Plant Code")
            {
            }
            column(SizeCodeDes; RecItm."Size Code Desc.")
            {
            }
            column(QualityCodeDes; RecItm."Quality Code Desc.")
            {
            }
            column(PackingCodeDes; RecItm."Packing Code Desc.")
            {
            }
            column(Des2; RecItm."Description 2")
            {
            }
            column(qty1; qty1)
            {
            }
            column(Totalforlocation; 'Total for location ' + Location1.Code)
            {
            }
            column(NetChgTot; NetChgTot)
            {
            }
            column(Qtysqmtot; Qtysqmtot)
            {
            }
            column(CostAmtActualTot; CostAmtActualTot)
            {
            }
            column(TotWt; TotWt)
            {
            }
            column(NetChangeGtot; NetChangeGtot)
            {
            }
            column(QtysqmGtot; QtysqmGtot)
            {
            }
            column(CostAmtGtot; CostAmtGtot)
            {
            }
            column(GTotWt; GTotWt)
            {
            }
            column(CompinfoName; Compinfo.Name)
            {
            }
            column(CompinfoName2; Compinfo."Name 2")
            {
            }
            column(ILEFilter; ILEFilter)
            {
            }
            column(date; FORMAT(TODAY, 0, 4))
            {
            }
            column(PAGENO1; CurrReport.PAGENO)
            {
            }
            column(NetChangeBoll; NetChangeBoll)
            {
            }
            column(RelationalLocationCode; "Item Ledger Entry"."Relational Location Code")
            {
            }
            column(uom; kbs)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Location1.GET("Location Code") THEN;
                InventorySetup.GET;
                TotalWeight := 0;
                QtySqm := 0;
                QtyMeasure := 0;

                IF IUOM.GET("Item Ledger Entry"."Item No.", InventorySetup."Unit of Measure for Carton") THEN
                    WeightPerCrtn := IUOM.Weight;

                IF uom.GET("Item Ledger Entry"."Item No.", 'SQ.MT') THEN
                    QtyMeasure := uom."Qty. per Unit of Measure";

                IF uom.GET("Item Ledger Entry"."Item No.", 'CRT') THEN
                    kbs := uom."Qty. per Unit of Measure";

                TotalWeight := "Item Ledger Entry".Quantity * WeightPerCrtn; //TRI A.S 08.05.08
                Bup := 0;
                //Code commented in earlier version
                /*SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.", "Item No.");
                SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::"Customer Price Group");
                SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                SalesPrice.SETRANGE("Variant Code","Variant Code");
                IF SalesPrice.FIND('+') THEN
                  MRP := SalesPrice.MRP;
                  BP  := SalesPrice."Unit Price";
                  Bup := BP + (MRP*0.57)* (ExcisePercentage/100);*/
                //Code commented in earlier version

                IF RecLoc.GET('SKD-PLANT') THEN BEGIN   //MSNK 190315
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Item No.", "Item No.");
                    //SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE("Sales Code", '27');
                    SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    //SalesPrice.SETRANGE("Variant Code","Variant Code");
                    IF SalesPrice.FIND('+') THEN
                        //MESSAGE('%1',SalesPrice.MRP);
                          MRP := SalesPrice."MRP Price";
                    BP := SalesPrice."Unit Price";
                END;
                IF RecLoc.GET('SKD-WH-MFG') THEN BEGIN  //MSNK 190315
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Item No.", "Item No.");
                    SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE("Sales Code", '27');
                    SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    //SalesPrice.SETRANGE("Variant Code","Variant Code");
                    IF SalesPrice.FIND('+') THEN
                        //MESSAGE('%1',SalesPrice.MRP);
                         MRP := SalesPrice."MRP Price";
                    BP := SalesPrice."Unit Price";

                END;
                IF RecLoc.GET('INTRAN') THEN BEGIN
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Item No.", "Item No.");
                    SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE("Sales Code", '27');
                    SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    //SalesPrice.SETRANGE("Variant Code","Variant Code");
                    IF SalesPrice.FIND('+') THEN
                        //MESSAGE('%1',SalesPrice.MRP);
                         MRP := SalesPrice."MRP Price";
                    BP := SalesPrice."Unit Price";

                END;

                IF (RecLoc.GET("Location Code")) THEN BEGIN
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Item No.", "Item No.");
                    SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETFILTER("Sales Code", '<>%1|<>%2|<>%3', 'SKD-PLANT', 'SKD-WH-MFG', 'INTRAN');
                    SalesPrice.SETRANGE("Sales Code", RecLoc."Customer Price Group");
                    SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    //SalesPrice.SETRANGE("Variant Code","Variant Code");
                    IF SalesPrice.FIND('+') THEN
                        //MESSAGE('%1',SalesPrice.MRP);
                         MRP := SalesPrice."MRP Price";
                    BP := SalesPrice."Unit Price";
                END;
                //Bup := BP + (MRP*0.57)* (ExcisePercentage/100);

                Wt := 0;
                IF RecItm.GET("Item No.") THEN;
                NetChange := 0;
                NetChangeBoll := FALSE;
                QtySqm := 0;
                qty1 := 0;
                CostAmtActual := 0;
                IF GlobalItemNo <> "Item No." THEN BEGIN

                    ItmLedgeEntry.RESET;
                    ItmLedgeEntry.SETRANGE("Item No.", "Item No.");
                    ItmLedgeEntry.SETRANGE("Location Code", "Location Code");
                    ItmLedgeEntry.SETFILTER("Posting Date", '%1..%2', 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    IF ItmLedgeEntry.FIND('-') THEN
                        REPEAT
                            ItmLedgeEntry.CALCFIELDS("Cost Amount (Actual)");
                            IF RecItm.GET("Item No.") THEN BEGIN
                                IF CatItem <> '' THEN BEGIN
                                    IF RecItm."Item Category Code" = CatItem THEN BEGIN
                                        //NetChange += ItmLedgeEntry.Quantity;
                                        NetChange += ItmLedgeEntry."Qty In Carton";
                                        qty1 += ItmLedgeEntry.Quantity;
                                        QtySqm += ItmLedgeEntry."Qty in Sq.Mt.";
                                        CostAmtActual += ItmLedgeEntry."Cost Amount (Actual)";
                                    END;
                                END ELSE BEGIN
                                    //NetChange +=  ItmLedgeEntry.Quantity;
                                    NetChange += ItmLedgeEntry."Qty In Carton";
                                    QtySqm += ItmLedgeEntry."Qty in Sq.Mt.";
                                    qty1 += ItmLedgeEntry.Quantity;
                                    CostAmtActual += ItmLedgeEntry."Cost Amount (Actual)";
                                END;
                            END;
                        UNTIL ItmLedgeEntry.NEXT = 0;
                END;
                GlobalItemNo := "Item No.";
                //IF (CurrReport.TOTALSCAUSEDBY="Item Ledger Entry".FIELDNO("Item Ledger Entry"."Item No.")) THEN BEGIN
                NetChgTot += NetChange;
                Wt := (RecItm."Gross Weight" * NetChange) / 1000;
                IF QtyMeasure <> 0 THEN BEGIN
                    //QtySqm := ROUND(NetChange/QtyMeasure,0.01);
                    //QtySqm := Quantity;
                    Qtysqmtot += QtySqm;
                    CostAmtActualTot += CostAmtActual;
                    TotWt += Wt;
                END;
                //END;
                //Qtysqmtot += QtySqm;
                IF NetChange = 0 THEN BEGIN
                    // 16630  CurrReport.SHOWOUTPUT := FALSE;
                    NetChangeBoll := TRUE;
                END;
                IF ("Location Code" = 'INTRAN') AND ("External Transfer" = TRUE) THEN BEGIN
                    rectransferShipment.RESET;
                    rectransferShipment.SETRANGE(rectransferShipment."No.", "Document No.");
                    IF rectransferShipment.FIND('-') THEN
                        targetLocation := rectransferShipment."Transfer-to Code";
                END;

                //check
                QtysqmGtot += Qtysqmtot;
                GTotWt += TotWt;
                //"Item Ledger Entry".CALCFIELDS("Item Ledger Entry"."Cost Amount (Actual)");
                CostAmtGtot += CostAmtActualTot;
                // MESSAGE('%1',CostAmtGtot);
                NetChangeGtot += NetChgTot;
                //check

            end;

            trigger OnPreDataItem()
            begin
                Qtysqmtot := 0;
                TotWt := 0;
                CostAmtActualTot := 0;
                InventorySetup.GET;
                TotalWeight := 0;
                QtySqm := 0;
                QtyMeasure := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Item Category Code"; CatItem)
                    {
                        TableRelation = "Item Category";
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

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50026)
    end;

    trigger OnPreReport()
    begin

        ILEFilter := "Item Ledger Entry".GETFILTERS;
        Compinfo.GET;
        IF PrintToExcel THEN BEGIN
            //MakeExcelInfo;
            ExcelBuffer.DELETEALL;
            RowNo := 0;
        END;
    end;

    var
        LocationWise: Boolean;
        ItemWise: Boolean;
        Item: Record Item;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        value: Decimal;
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        Tvalue: Decimal;
        ILE: Record "Item Ledger Entry";
        TQTY: Decimal;
        LOCNAME: Text[30];
        qty: Decimal;
        SalesPrice: Record "Sales Price";
        CustPrGr: Record "Customer Price Group";
        Bup: Decimal;
        BP: Decimal;
        MRP: Decimal;
        ExcisePercentage: Decimal;
        LocationCode: Code[20];
        RecItm: Record Item;
        NetChange: Decimal;
        ItmLedgeEntry: Record "Item Ledger Entry";
        QtySqm: Decimal;
        PostDate: Text[30];
        minDate: Date;
        maxDate: Date;
        NetChgTot: Decimal;
        Qtysqmtot: Decimal;
        QtyInSqm: Decimal;
        QtyInWt: Decimal;
        IUOM: Record "Item Unit of Measure";
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        InventorySetup: Record "Inventory Setup";
        WeightPerCrtn: Decimal;
        uom: Record "Item Unit of Measure";
        QtyMeasure: Decimal;
        TotalWeight: Decimal;
        Compinfo: Record "Company Information";
        QtysqmGtot: Decimal;
        TotWt: Decimal;
        GTotWt: Decimal;
        ILEFilter: Text[400];
        CatItem: Code[100];
        CostAmtActual: Decimal;
        CostAmtActualTot: Decimal;
        CostAmtGtot: Decimal;
        NetChangeGtot: Decimal;
        Wt: Decimal;
        RecLoc: Record Location;
        rectransferShipment: Record "Transfer Shipment Header";
        targetLocation: Code[30];
        ExcelBuffer: Record "Excel Buffer" temporary;
        RowNo: Integer;
        qty1: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        TotalFor: Label 'Total for ';
        Text1007: Label 'Item Stock By Location Report';
        Text1001: Label 'For the Period';
        Text1000: Label 'Period: %1';
        Text1002: Label 'Data';
        Text1005: Label 'Company Name';
        Text1006: Label 'Report No.';
        Text1008: Label 'User ID';
        Text1009: Label 'Print Date';
        Text000: Label 'Document';
        cat_code: Code[20];
        Location_code: Code[20];
        NetChangeBoll: Boolean;
        Location1: Record Location;
        GlobalItemNo: Code[30];
        kbs: Decimal;
}

