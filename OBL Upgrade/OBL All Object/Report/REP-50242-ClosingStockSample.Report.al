report 50242 "Closing Stock Sample"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ClosingStockSample.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Item Category Code");
            RequestFilterFields = "No.", "Item Category Code", "Base Unit of Measure", Inventory, "Location Filter";
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(Filters; Filters)
            {
            }
            column(ItemCategoryDesc; ItemCategoryDesc)
            {
            }
            column(No; Item."No.")
            {
            }
            column(Description; Item.Description)
            {
            }
            column(Description2; Item."Description 2")
            {
            }
            column(BaseUnitOfMeasure; Item."Base Unit of Measure")
            {
            }
            column(QtyInSqm; QtyInSqm)
            {
            }
            column(NetChange; Item."Net Change")
            {
            }
            column(QtyInCrt; QtyInCrt)
            {
            }
            column(value; value)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(ItemCategoryCode; Item."Item Category Code")
            {
            }
            column(TotalPicsValue; QtyInSqm * PicsValue)
            {
            }

            trigger OnAfterGetRecord()
            begin

                ItemCategoryDesc := '';
                IF ItemCategory.GET("Item Category Code") THEN
                    ItemCategoryDesc := ItemCategory.Description;

                CLEAR(PicsValue);
                IUOM.RESET;
                IUOM.SETCURRENTKEY("Item No.", Code);
                IUOM.SETFILTER(Code, '%1', 'PCS.');
                IUOM.SETRANGE("Item No.", Item."No.");
                IF IUOM.FINDFIRST THEN BEGIN
                    PicsValue := IUOM."Qty. per Unit of Measure";
                END;


                CurrReport.CREATETOTALS(ToTqtyInSqm);
                InventorySetup.GET;
                ItemUnitOfMeasure.RESET;
                ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure."Item No.", Item."No.");
                ItemUnitOfMeasure.SETFILTER(ItemUnitOfMeasure.Code, InventorySetup."Unit of Measure for Sq. Mt.");
                IF ItemUnitOfMeasure.FIND('-') THEN BEGIN
                    QtyPerC := ItemUnitOfMeasure."Qty. per Unit of Measure";
                    ItemUnitofMeasure1.RESET;
                    ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1."Item No.", Item."No.");
                    ItemUnitofMeasure1.SETFILTER(ItemUnitofMeasure1.Code, Item."Base Unit of Measure");
                    IF ItemUnitofMeasure1.FIND('-') THEN
                        QtyPerU := ItemUnitofMeasure1."Qty. per Unit of Measure";
                    Item.CALCFIELDS("Inventory In CRT", "Net Change");
                    //Item.CALCFIELDS("Inventory In SQMT","Net Change");
                    // TRI SC
                    /*
                   IF (Item."Net Change" <> 0) THEN
                   QtyInSqm := ("Net Change" * QtyPerU)/QtyPerC;
                   */
                END;


                Item.CALCFIELDS("Net Change");
                IF "Net Change" <> 0 THEN //MS040818
                    QtyInCrt := ROUND(Item.UomToCart("No.", Item."Base Unit of Measure", "Net Change"), 1, '=');
                //TRI SC.
                //QtyInSqm :=ROUND(Item.UomToSqm("No.",Item."Base Unit of Measure","Net Change"),0.02,'=');
                //IF "Net Change" = 0 THEN
                //CurrReport.SKIP;
                IF "Net Change" = 0 THEN
                    CurrReport.SKIP;
                QtyInSqm := "Net Change";
                ToTqtyInSqm += QtyInSqm;
                value := 0;
                Item.CALCFIELDS("Net Change", "Inventory In CRT");
                //Item.CALCFIELDS("Net Change","Inventory In SQMT");
                //IF Miniqty THEN BEGIN
                //IF PrintToExcel THEN BEGIN


                IF ((Miniqty = TRUE) AND (Item."Net Change" >= "Min Qty") AND (Item."Net Change" <> 0)) THEN BEGIN
                    ItemCostMgt.CalculateAverageCost(Item, AverageCostLCY, AverageCostACY);
                    value := Item."Net Change" * AverageCostLCY;
                    //Quantity := Item."Net Change";
                    //QtyInSqm := Item.UomToSqm("No.","Base Unit of Measure",Quantity);

                END
                ELSE
                    IF ((Item."Net Change" <> 0) AND (Miniqty = FALSE)) THEN BEGIN
                        ItemCostMgt.CalculateAverageCost(Item, AverageCostLCY, AverageCostACY);
                        value := Item."Net Change" * AverageCostLCY;
                        //Quantity := Item."Net Change";
                        //END;
                        Rowno += 1;
                        /*
                       EnterCell(Rowno,1,'C'+"No.",FALSE,FALSE);
                       EnterCell(Rowno,2,Description+' '+"Description 2",FALSE,FALSE);
                       EnterCell(Rowno,3,"Base Unit of Measure",FALSE,FALSE);
                       EnterCell(Rowno,4,FORMAT(QtyInSqm),FALSE,FALSE);
                      // EnterCell(Rowno,5,FORMAT("Net Change"),FALSE,FALSE);
                       EnterCell(Rowno,6,FORMAT(QtyInCrt),FALSE,FALSE);
                       EnterCell(Rowno,7,FORMAT(value),FALSE,FALSE);
                       */
                        // END;
                    END;
                IF QtyInCrt = 0 THEN
                    CLEAR(value);

            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";

                /*
               ItemCategoryDesc := '';
               IF ItemCategory.GET("Item Category Code") THEN
                 ItemCategoryDesc := ItemCategory.Description;
                    */
                //CurrReport.SHOWOUTPUT(CurrReport.PAGENO = 1);
                //SETRANGE("Date Filter",0D,ToDate);
                SETRANGE("Date Filter", 0D, ToDate);//TRI A.S 08.05.08
                //MSAK.BEGIN 070515
                IF (Item.GETFILTER("Location Filter") = 'SKD-PLANT') OR (Item.GETFILTER("Location Filter") = 'DRA-PLANT')
                    OR (Item.GETFILTER("Location Filter") = 'HSK-PLANT') THEN
                    SETFILTER("Location Filter", GetLocations(Item.GETFILTER("Location Filter")));
                //MSAK.END 070515
                //MSAK.BEGIN 070515


                //MSAK.END 070515

                //Kulbhushan End 091013
                ToTqtyInSqm := 0;

                LastFieldNo := FIELDNO("No.");
                CurrReport.CREATETOTALS(value, Quantity, QtyInSqm, QtyInCrt);
                /*
             IF (PrintToExcel) AND (CurrReport.PAGENO = 1) THEN BEGIN
               Rowno += 1;
               EnterCell(Rowno,1,'Closing Stock - Stores ' ,TRUE,TRUE);
                 Rowno += 1;
               EnterCell(Rowno,1,CompanyName1,TRUE,TRUE);
                 Rowno += 1;
               EnterCell(Rowno,1,'Estimated Inventory As On:'+FORMAT(ToDate),TRUE,TRUE);
                 Rowno += 1;
               EnterCell(Rowno,1 ,Filters,TRUE,TRUE);
               Rowno += 1;
               EnterCell(Rowno,5,'<--------------Closing Stock---------->',TRUE,TRUE);
               Rowno += 1;
               EnterCell(Rowno,1,'Item No.',TRUE,TRUE);
               EnterCell(Rowno,2,'Item Desc.',TRUE,TRUE);
               EnterCell(Rowno,3,'UOM',TRUE,TRUE);
               EnterCell(Rowno,4,'Qty in SQM',TRUE,TRUE);

              // EnterCell(Rowno,5,'Quantity',TRUE,TRUE);
               EnterCell(Rowno,6,'Qty in CRT',TRUE,TRUE);
               EnterCell(Rowno,7,'Value',TRUE,TRUE);
             END;

             IF (PrintToExcel) AND (CurrReport.PAGENO = 1) THEN BEGIN
               Rowno += 1;
               EnterCell(Rowno,5,'<--------------Closing Stock---------->',TRUE,TRUE);
               Rowno += 1;
               EnterCell(Rowno,1,'Item No.',TRUE,TRUE);
               EnterCell(Rowno,2,'Item Desc.',TRUE,TRUE);
               EnterCell(Rowno,3,'UOM',TRUE,TRUE);
               EnterCell(Rowno,4,'Qty in SQM',TRUE,TRUE);

              // EnterCell(Rowno,5,'Quantity',TRUE,TRUE);
               EnterCell(Rowno,6,'Qty in CRT',TRUE,TRUE);
               EnterCell(Rowno,7,'Value',TRUE,TRUE);
             END;
               */

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
                group(Control1000000001)
                {
                    field("As On Date. . . . . . . ."; ToDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Plant Code. . . . . . ."; Plant)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            InventorySetup.GET;
                            DimensionValue.RESET;
                            DimensionValue.SETFILTER(DimensionValue."Dimension Code", '%1', InventorySetup."Plant Code");
                            IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                                Plant := DimensionValue.Code;
                        end;

                        trigger OnValidate()
                        begin

                            IF Plant <> '' THEN BEGIN
                                DimensionValue.RESET;
                                InventorySetup.GET;
                                IF NOT DimensionValue.GET(InventorySetup."Plant Code", Plant) THEN
                                    ERROR('Plant Code does not Exist');
                            END;
                        end;
                    }
                    field("Mini Qty . . . . . . . ."; Miniqty)
                    {
                        ApplicationArea = All;
                    }
                    field("Min Qty . . . . . . . "; "Min Qty")
                    {
                        ApplicationArea = All;
                    }
                    field("Warehouse Location . ."; WhreLoc)
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

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50238)
    end;

    trigger OnPreReport()
    begin


        IF Item.GETFILTER(Item."Date Filter") <> '' THEN BEGIN
            IF STRPOS(FORMAT(Item.GETFILTER(Item."Date Filter")), '.')
              <> STRLEN(FORMAT(Item.GETFILTER(Item."Date Filter"))) - 1 THEN
                Date := FORMAT(Item.GETRANGEMAX(Item."Date Filter"), 0, 4)
        END ELSE
            Date := FORMAT(TODAY, 0, 4);

        IF WhreLoc = TRUE THEN
            Filters := 'Warehouse Location : ' + FORMAT('WhreLoc|MF 1')
        ELSE
            IF Plant <> '' THEN
                Filters := 'Plant Code : ' + Plant;

        IF "Min Qty" <> 0 THEN
            Filters := Filters + ' Min Qty : ' + FORMAT("Min Qty");

        Filters := Filters + ' ' + Item.GETFILTERS;
        Rowno := 0;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        value: Decimal;
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        Date: Text[30];
        Filters: Text[500];
        ItemCategory: Record "Item Category";
        ItemCategoryDesc: Text[60];
        "Min Qty": Decimal;
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        Plant: Code[10];
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        WhreLoc: Boolean;
        Loc: Record Location;
        LocationFilterString: Text[250];
        Quantity: Decimal;
        ResQty: Decimal;
        Miniqty: Boolean;
        RecItemLedgEntry: Record "Item Ledger Entry";
        QtyInSqm: Decimal;
        QtyInWt: Decimal;
        IUOM: Record "Item Unit of Measure";
        QtyPerC: Decimal;
        QtyPerU: Decimal;
        ItemUnitofMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        QtyInCrt: Decimal;
        ToTqtyInSqm: Decimal;
        PrintToExcel: Boolean;
        ExcelBuffer: Record "Excel Buffer" temporary;
        Rowno: Integer;
        ToDate: Date;
        Var1: Date;
        CompanyName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        PicsValue: Decimal;


    procedure GetLocations(LocationCode: Code[10]): Text[800]
    var
        Loc: Text[800];
        Location: Record Location;
    begin
        //MSAK.BEGIN 070515
        Location.RESET;
        Location.SETFILTER(Code, COPYSTR(LocationCode, 1, 3) + '*');
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := Location.Code
                ELSE
                    Loc := Loc + '|' + Location.Code;
            UNTIL Location.NEXT = 0;
        END;
        IF LocationCode = 'SKD-PLANT' THEN
            EXIT(Loc + '|' + 'O-INTRAN');
        IF LocationCode = 'HSK-PLANT' THEN
            EXIT(Loc + '|' + 'B-INTRAN');
        EXIT(Loc);
        //MSAK.END 070515
    end;
}

