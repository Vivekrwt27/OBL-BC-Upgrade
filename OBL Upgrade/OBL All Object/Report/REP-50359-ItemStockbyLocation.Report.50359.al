report 50359 "Item Stock by Location.."
{
    // TRIRJ ORIENT2.01 04-12-08:Created New report for Location wise Item Stock
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ItemStockbyLocation.50359.rdl';


    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING("Related Location Code", "Code");
            RequestFilterFields = "Code";
            column(Code_Location; Location.Code)
            {
            }
            column(Name_Location; Location.Name)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Cost Amount (Actual)";
                DataItemLink = "Location Code" = FIELD("Code");
                DataItemTableView = SORTING("Location Code", "Item No.", "Variant Code", Open, Positive, "Posting Date");
                RequestFilterFields = "Posting Date", "Design Code", "Inventory Posting Group", "Location Code";
                column(row1; "Item Ledger Entry"."Item No.")
                {
                }
                column(row2; RecItm.Description)
                {
                }
                column(row3; "Item Ledger Entry"."Location Code")
                {
                }
                column(row4; RecItm."Base Unit of Measure")
                {
                }
                column(row5; NetChange)
                {
                }
                column(row6; QtySqm)
                {
                }
                column(row7; CostAmtActual)
                {
                }
                column(row9; RecItm."Unit Cost")
                {
                }
                column(row10; RecItm."Last Direct Cost")
                {
                }
                column(row11; BP)
                {
                }
                column(row12; MRP)
                {
                }
                column(row13; Wt)
                {
                }
                column(row14; targetLocation)
                {
                }
                column(row15; RecItm."Gross Weight")
                {
                }
                column(row16; RecItm."Net Weight")
                {
                }
                column(row17; RecItm."Inventory Posting Group")
                {
                }
                column(row18; RecItm."Item Category Code")
                {
                }
                column(row19; RecItm."Plant Code")
                {
                }
                column(row20; RecItm."Size Code Desc.")
                {
                }
                column(row21; RecItm."Quality Code Desc.")
                {
                }
                column(row22; RecItm."Packing Code Desc.")
                {
                }
                column(row23; RecItm."Description 2")
                {
                }
                column(row24; RecItm."Item Classification")
                {
                }
                column(NetChgTot; NetChgTot)
                {
                }
                column(TotWt; TotWt)
                {
                }
                column(CostAmtActualTot; CostAmtActualTot)
                {
                }
                column(Qtysqmtot; Qtysqmtot)
                {
                }
                column(ILEFilter; ILEFilter)
                {
                }
                column(CompName1; Compinfo.Name)
                {
                }
                column(CompName2; Compinfo."Name 2")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF LocationTemp <> Location.Code THEN BEGIN
                        CLEAR(NetChgTot);
                        CLEAR(Qtysqmtot);
                        CLEAR(CostAmtActualTot);
                        CLEAR(TotWt);
                    END;

                    InventorySetup.GET;
                    TotalWeight := 0;

                    QtySqm := 0;
                    QtyMeasure := 0;

                    IF IUOM.GET("Item Ledger Entry"."Item No.", InventorySetup."Unit of Measure for Carton") THEN
                        WeightPerCrtn := IUOM.Weight;

                    IF uom.GET("Item Ledger Entry"."Item No.", 'SQ.MT') THEN
                        QtyMeasure := uom."Qty. per Unit of Measure";

                    TotalWeight := "Item Ledger Entry".Quantity * WeightPerCrtn; //TRI A.S 08.05.08
                    Bup := 0;

                    /*SalesPrice.RESET;
                    SalesPrice.SETRANGE("Item No.", "Item No.");
                    SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::"Customer Price Group");
                    SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    SalesPrice.SETRANGE("Variant Code","Variant Code");
                    IF SalesPrice.FIND('+') THEN
                      MRP := SalesPrice.MRP;
                      BP  := SalesPrice."Unit Price";
                      Bup := BP + (MRP*0.57)* (ExcisePercentage/100);*/

                    IF RecLoc.GET('plant') THEN BEGIN
                        SalesPrice.RESET;
                        SalesPrice.SETRANGE("Item No.", "Item No.");
                        //SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::"Customer Price Group");
                        SalesPrice.SETRANGE("Sales Code", '27');
                        SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                        //SalesPrice.SETRANGE("Variant Code","Variant Code");
                        IF SalesPrice.FIND('+') THEN
                            //MESSAGE('%1',SalesPrice.MRP);
                            //16225 MRP := SalesPrice."MRP Price";
                            BP := SalesPrice."Unit Price";
                    END;
                    IF RecLoc.GET('warehouse') THEN BEGIN
                        SalesPrice.RESET;
                        SalesPrice.SETRANGE("Item No.", "Item No.");
                        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                        SalesPrice.SETRANGE("Sales Code", '27');
                        SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));

                        //SalesPrice.SETRANGE("Variant Code","Variant Code");
                        IF SalesPrice.FIND('+') THEN
                            //MESSAGE('%1',SalesPrice.MRP);
                            //16225  MRP := SalesPrice."MRP Price";
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
                            //16225    MRP := SalesPrice."MRP Price";
                            BP := SalesPrice."Unit Price";

                    END;

                    IF (RecLoc.GET("Location Code")) THEN BEGIN
                        SalesPrice.RESET;
                        SalesPrice.SETRANGE("Item No.", "Item No.");
                        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                        SalesPrice.SETFILTER("Sales Code", '<>%1|<>%2|<>%3', 'PLANT', 'WAREHOUSE', 'INTRAN');
                        SalesPrice.SETRANGE("Sales Code", RecLoc."Customer Price Group");
                        SalesPrice.SETRANGE("Starting Date", 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                        //SalesPrice.SETRANGE("Variant Code","Variant Code");
                        IF SalesPrice.FIND('+') THEN
                            //MESSAGE('%1',SalesPrice.MRP);
                            //16225    MRP := SalesPrice."MRP Price";
                            BP := SalesPrice."Unit Price";
                    END;
                    //Bup := BP + (MRP*0.57)* (ExcisePercentage/100);


                    //16225   CurrReport.SHOWOUTPUT := CurrReport.TOTALSCAUSEDBY = FIELDNO("Item No.");

                    //IF Location.GET("Location Code")THEN;
                    Wt := 0;
                    IF RecItm.GET("Item No.") THEN;
                    NetChange := 0;

                    QtySqm := 0;
                    CostAmtActual := 0;
                    ItmLedgeEntry.RESET;
                    ItmLedgeEntry.SETRANGE("Item No.", "Item No.");
                    ItmLedgeEntry.SETRANGE("Location Code", "Location Code");
                    ItmLedgeEntry.SETFILTER("Posting Date", '%1..%2', 0D, "Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    //ItmLedgeEntry.SETFILTER("Posting Date",'..%1',"Item Ledger Entry".GETRANGEMAX("Posting Date"));
                    IF ItmLedgeEntry.FIND('-') THEN
                        REPEAT
                            ItmLedgeEntry.CALCFIELDS("Cost Amount (Actual)");
                            IF RecItm.GET("Item No.") THEN BEGIN
                                IF CatItem <> '' THEN BEGIN
                                    IF RecItm."Item Category Code" = CatItem THEN BEGIN
                                        //NetChange += ItmLedgeEntry.Quantity;
                                        IF RecItm."Base Unit of Measure" = 'PCS.' THEN //MSAK010515
                                            NetChange += ItmLedgeEntry.Quantity //MSAK010515
                                        ELSE
                                            NetChange += ItmLedgeEntry."Qty In Carton";
                                        QtySqm += ItmLedgeEntry."Qty in Sq.Mt.";
                                        CostAmtActual += ItmLedgeEntry."Cost Amount (Actual)";
                                    END;
                                END ELSE BEGIN
                                    //NetChange +=  ItmLedgeEntry.Quantity;
                                    IF RecItm."Base Unit of Measure" = 'PCS.' THEN //MSAK010515
                                        NetChange += ItmLedgeEntry.Quantity //MSAK010515
                                    ELSE
                                        NetChange += ItmLedgeEntry."Qty In Carton";
                                    QtySqm += ItmLedgeEntry."Qty in Sq.Mt.";
                                    CostAmtActual += ItmLedgeEntry."Cost Amount (Actual)";
                                END;
                            END;
                        UNTIL ItmLedgeEntry.NEXT = 0;
                    //IF (CurrReport.TOTALSCAUSEDBY="Item Ledger Entry".FIELDNO("Item Ledger Entry"."Item No.")) THEN BEGIN
                    Wt := (RecItm."Gross Weight" * NetChange) / 1000;
                    IF ItemTemp <> "Item Ledger Entry"."Item No." THEN BEGIN
                        NetChgTot += NetChange;

                        IF QtyMeasure <> 0 THEN BEGIN
                            //QtySqm := ROUND(NetChange/QtyMeasure,0.01);
                            //QtySqm := Quantity;
                            Qtysqmtot += QtySqm;
                            CostAmtActualTot += CostAmtActual;
                            TotWt += Wt;
                        END;

                    END;

                    //END;
                    //Qtysqmtot += QtySqm;
                    IF NetChange = 0 THEN
                        //16225   CurrReport.SHOWOUTPUT := FALSE;
                        IF ("Location Code" = 'INTRAN') AND ("External Transfer" = TRUE) THEN BEGIN
                            rectransferShipment.RESET;
                            rectransferShipment.SETRANGE(rectransferShipment."No.", "Document No.");
                            IF rectransferShipment.FIND('-') THEN
                                targetLocation := rectransferShipment."Transfer-to Code";
                        END;


                    QtysqmGtot += Qtysqmtot;
                    GTotWt += TotWt;
                    //"Item Ledger Entry".CALCFIELDS("Item Ledger Entry"."Cost Amount (Actual)");
                    CostAmtGtot += CostAmtActualTot;
                    // MESSAGE('%1',CostAmtGtot);
                    NetChangeGtot += NetChgTot;

                    ItemTemp := "Item Ledger Entry"."Item No.";
                    LocationTemp := Location.Code;

                end;

                trigger OnPreDataItem()
                begin
                    //SETFILTER("Relational Location Code",LocationCode);
                    Qtysqmtot := 0;
                    TotWt := 0;
                    CostAmtActualTot := 0;
                    CLEAR(ItemTemp);
                    //"Item Ledger Entry".SETRANGE("Item No.",'020205300010355102H');
                end;
            }

            trigger OnAfterGetRecord()
            begin

                InventorySetup.GET;
                TotalWeight := 0;
                QtySqm := 0;
                QtyMeasure := 0;
            end;

            trigger OnPreDataItem()
            begin

                CurrReport.CREATETOTALS(qty, "Item Ledger Entry".Quantity, "Item Ledger Entry"."Cost Amount (Actual)", value,
                                           "Item Ledger Entry"."Qty in Sq.Mt.", "Item Ledger Entry"."Qty In Carton", NetChange, TotalWeight);
                CurrReport.CREATETOTALS(QtySqm);
                //MSAK010515
                //SETRANGE(Code,VarLocation);
                IF GetLocations <> '' THEN
                    SETFILTER(Code, GetLocations);


                //Location.SETFILTER(Code,'%1|%2','DP-CALICUT','DP-BLORE1');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000001)
                {
                    field("Location Code"; VarLocation)
                    {
                        TableRelation = Location;
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

    trigger OnPreReport()
    begin

        ILEFilter := "Item Ledger Entry".GETFILTERS;
        Compinfo.GET;
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
        CatItem: Code[20];
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
        VarLocation: Code[20];
        RecUserLocation: Record "User Location";
        StateCode1: Code[10];
        AsonDate: Date;
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
        ItemTemp: Code[30];
        LocationTemp: Code[30];

    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
        UserLocation: Record "User Location";
    begin
        //MSAK.Begin 01-05-15
        UserLocation.RESET;
        UserLocation.SETRANGE("User ID", USERID);
        UserLocation.SETFILTER("Create Sales Order", '%1', TRUE);
        IF UserLocation.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := UserLocation."Location Code"
                ELSE
                    Loc := Loc + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;
        END;
        EXIT(Loc);
        //MSAK.End 01-05-15
    end;
}

