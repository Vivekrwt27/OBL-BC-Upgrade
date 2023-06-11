report 50316 "BOM Vs Actual Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\BOMVsActualReport.rdl';
    Caption = 'BOM Vs Actual Report';

    dataset
    {
        dataitem(DataItem8129; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group";
            column(AsOfCalcDate; Text000 + FORMAT(CalculateDate))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(ItemTableCaptionFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Desc_Item; Description)
            {
            }
            column(QtyExplosionofBOMCapt; QtyExplosionofBOMCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(BOMQtyCaption; BOMQtyCaptionLbl)
            {
            }
            column(BomCompLevelQtyCapt; BomCompLevelQtyCaptLbl)
            {
            }
            column(BomCompLevelDescCapt; BomCompLevelDescCaptLbl)
            {
            }
            column(BomCompLevelNoCapt; BomCompLevelNoCaptLbl)
            {
            }
            column(LevelCapt; LevelCaptLbl)
            {
            }
            column(BomCompLevelUOMCodeCapt; BomCompLevelUOMCodeCaptLbl)
            {
            }
            dataitem(BOMLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(DataItem5444; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(BomCompLevelNo; BomComponent[Level]."No.")
                    {
                    }
                    column(BomCompLevelDesc; BomComponent[Level].Description)
                    {
                    }
                    column(BOMQty; BOMQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(FormatLevel; PADSTR('', Level, ' ') + FORMAT(Level))
                    {
                    }
                    column(BomCompLevelQty; BomComponent[Level].Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(BomCompLevelUOMCode; BomComponent[Level]."Unit of Measure Code")
                    {
                        //16225 DecimalPlaces = 0 : 5;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Level > 1 THEN
                            BOMQty := BomComponent[Level].Quantity * BomComponent[Level - 1].Quantity//Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
                        ELSE
                            BOMQty := BomComponent[Level].Quantity;
                        IF NOT MultiLevel THEN
                            IF Level > 1 THEN
                                CurrReport.SKIP;

                        ItemAmount.RESET;
                        ItemAmount.SETFILTER("Item No.", '%1', BomComponent[1]."No.");
                        IF ItemAmount.FINDFIRST THEN BEGIN
                            ItemAmount.Quantity := 0;
                            ItemAmount.MODIFY;
                        END;


                        TempExcelBuffer.AddColumn(FORMAT(DimVal.Name), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(CompItem."Inventory Posting Group"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(Item."No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        //TempExcelBuffer.AddColumn(FORMAT(Item."No."),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(BomComponent[Level]."No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(FGOutput), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //TempExcelBuffer.AddColumn(FORMAT(CalculateOutput(BomComponent[Level]."No.")),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT(BomComponent[Level].Description), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(BomComponent[Level]."Unit of Measure Code"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(BOMQty), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty * FGOutput, 0.01, '=')), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //MS
                        TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty * FGOutput * Item."Unit Cost", 0.01, '=')), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //MS
                        IF Level = 1 THEN BEGIN
                            ConsumptionQty := CalculateConsumption(Item."No.", BomComponent[Level]."No.");
                            TempExcelBuffer.AddColumn(FORMAT(ConsumptionQty), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty * FGOutput, 0.01, '=') - ConsumptionQty), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            //MS
                            TempExcelBuffer.AddColumn(FORMAT(ConsumptionQty * Item."Unit Cost"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn(FORMAT((ConsumptionQty * Item."Unit Cost") - (ROUND(BOMQty * FGOutput * Item."Unit Cost", 0.01, '='))), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            //MS
                        END ELSE BEGIN
                            //IF MfgItem THEN
                            //  TempExcelBuffer.AddColumn(FORMAT(CalculateConsumption(BomComponent[Level-1]."No.",BomComponent[Level]."No.")),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number)
                            //ELSE
                            ConsumptionQty := CalculateConsumption(BomComponent[Level - 1]."No.", BomComponent[Level]."No.");
                            TempExcelBuffer.AddColumn(FORMAT(CalculateConsumption(BomComponent[Level - 1]."No.", BomComponent[Level]."No.")), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty * FGOutput, 0.01, '=') - ConsumptionQty), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            //MS
                            TempExcelBuffer.AddColumn(FORMAT((CalculateConsumption(BomComponent[Level - 1]."No.", BomComponent[Level]."No.")) * Item."Unit Cost"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn(FORMAT(((CalculateConsumption(BomComponent[Level - 1]."No.", BomComponent[Level]."No.")) * Item."Unit Cost")
                            - (ROUND(BOMQty * FGOutput * Item."Unit Cost", 0.01, '='))), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                            //MS
                        END;
                        IF Level > 1 THEN
                            TempExcelBuffer.AddColumn(FORMAT(BomComponent[Level].Quantity * BomComponent[Level - 1].Quantity), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        IF (Level = 1) AND (NOT MfgItem) THEN
                            TempExcelBuffer.AddColumn(FORMAT(CalculateConsumptionAmount(Item."No.", BomComponent[Level]."No.")), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                        ELSE
                            TempExcelBuffer.AddColumn(FORMAT(0), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT('In-Bom Items'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        //Kulwant
                        TempExcelBuffer.NewRow;
                    end;

                    trigger OnPostDataItem()
                    begin
                        Level := NextLevel;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    BomItem: Record Item;
                begin
                    WHILE BomComponent[Level].NEXT = 0 DO BEGIN
                        Level := Level - 1;
                        IF Level < 1 THEN
                            CurrReport.BREAK;
                    END;
                    MfgItem := FALSE;
                    NextLevel := Level;
                    CLEAR(CompItem);
                    QtyPerUnitOfMeasure := 1;
                    CASE BomComponent[Level].Type OF
                        BomComponent[Level].Type::Item:
                            BEGIN
                                CompItem.GET(BomComponent[Level]."No.");
                                IF CompItem."Production BOM No." <> '' THEN BEGIN
                                    ProdBOM.GET(CompItem."Production BOM No.");
                                    MfgItem := TRUE;
                                    IF ProdBOM.Status = ProdBOM.Status::Closed THEN
                                        CurrReport.SKIP;
                                    NextLevel := Level + 1;
                                    IF Level > 1 THEN
                                        IF (NextLevel > 50) OR (BomComponent[Level]."No." = NoList[Level - 1]) THEN
                                            ERROR(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    CLEAR(BomComponent[NextLevel]);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::Item;
                                    NoList[NextLevel] := CompItem."No.";
                                    VersionCode[NextLevel] :=
                                      VersionMgt.GetBOMVersion(CompItem."Production BOM No.", CalculateDate, TRUE);
                                    BomComponent[NextLevel].SETRANGE("Production BOM No.", CompItem."Production BOM No.");
                                    BomComponent[NextLevel].SETRANGE("Version Code", VersionCode[NextLevel]);
                                    BomComponent[NextLevel].SETFILTER("Starting Date", '%1|..%2', 0D, CalculateDate);
                                    BomComponent[NextLevel].SETFILTER("Ending Date", '%1|%2..', 0D, CalculateDate);
                                END;
                                IF Level > 1 THEN
                                    IF BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item THEN
                                        IF BomItem.GET(BomComponent[Level - 1]."No.") THEN
                                            QtyPerUnitOfMeasure :=
                                              UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code") /
                                              UOMMgt.GetQtyPerUnitOfMeasure(
                                                BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                            END;
                        BomComponent[Level].Type::"Production BOM":
                            BEGIN
                                ProdBOM.GET(BomComponent[Level]."No.");
                                IF ProdBOM.Status = ProdBOM.Status::Closed THEN
                                    CurrReport.SKIP;
                                NextLevel := Level + 1;
                                IF Level > 1 THEN
                                    IF (NextLevel > 50) OR (BomComponent[Level]."No." = NoList[Level - 1]) THEN
                                        ERROR(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                CLEAR(BomComponent[NextLevel]);
                                NoListType[NextLevel] := NoListType[NextLevel] ::"Production BOM";
                                NoList[NextLevel] := ProdBOM."No.";
                                VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.", CalculateDate, FALSE);
                                BomComponent[NextLevel].SETRANGE("Production BOM No.", NoList[NextLevel]);
                                BomComponent[NextLevel].SETRANGE("Version Code", VersionCode[NextLevel]);
                                BomComponent[NextLevel].SETFILTER("Starting Date", '%1|..%2', 0D, CalculateDate);
                                BomComponent[NextLevel].SETFILTER("Ending Date", '%1|%2..', 0D, CalculateDate);
                            END;
                    END;

                    ItemAmount.RESET;
                    ItemAmount.SETRANGE("Item No.", BomComponent[1]."No.");
                    IF ItemAmount.FINDFIRST THEN BEGIN
                        ItemAmount.Quantity := 0;
                        ItemAmount.MODIFY;
                    END;

                    IF NextLevel <> Level THEN
                        Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                end;

                trigger OnPreDataItem()
                begin
                    Level := 1;

                    ProdBOM.GET(Item."Production BOM No.");

                    VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.", CalculateDate, FALSE);
                    CLEAR(BomComponent);
                    BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                    BomComponent[Level].SETRANGE("Production BOM No.", Item."Production BOM No.");
                    BomComponent[Level].SETRANGE("Version Code", VersionCode[Level]);
                    BomComponent[Level].SETFILTER("Starting Date", '%1|..%2', 0D, CalculateDate);
                    BomComponent[Level].SETFILTER("Ending Date", '%1|%2..', 0D, CalculateDate);
                    NoListType[Level] := NoListType[Level] ::Item;
                    NoList[Level] := Item."No.";
                    Quantity[Level] :=
                      UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Base Unit of Measure") /
                      UOMMgt.GetQtyPerUnitOfMeasure(
                        Item,
                        VersionMgt.GetBOMUnitOfMeasure(
                          Item."Production BOM No.", VersionCode[Level]));
                end;
            }
            dataitem(NonBomItem; Integer)
            {

                trigger OnAfterGetRecord()
                var
                    ComponentItem: Record Item;
                begin
                    //IF ItemAmount."Item No." = Item."No." THEN
                    //  CurrReport.SKIP;
                    BOMQty := 0;
                    IF ComponentItem.GET(ItemAmount."Item No.") AND (ItemAmount."Item No." <> Item."No.") THEN BEGIN
                        TempExcelBuffer.AddColumn(FORMAT(DimVal.Name), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(ComponentItem."Inventory Posting Group"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(Item."No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        //TempExcelBuffer.AddColumn(FORMAT(Item."No."),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(ComponentItem."No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(FGOutput), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //TempExcelBuffer.AddColumn(FORMAT(CalculateOutput(BomComponent[Level]."No.")),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT(ComponentItem.Description), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(ComponentItem."Base Unit of Measure"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(FORMAT(0), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT(0), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //MS
                        TempExcelBuffer.AddColumn(FORMAT(0 * Item."Unit Cost"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //MS
                        ConsumptionQty := CalculateConsumption(Item."No.", ComponentItem."No.");
                        TempExcelBuffer.AddColumn(FORMAT(ConsumptionQty), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty * FGOutput, 0.01, '=') - ConsumptionQty), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //MS
                        TempExcelBuffer.AddColumn(FORMAT(ConsumptionQty * Item."Unit Cost"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT(0 - (ConsumptionQty * Item."Unit Cost")), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        //MS
                        /*
                        IF Level = 1 THEN BEGIN
                          ConsumptionQty :=CalculateConsumption(Item."No.",ComponentItem."No.");
                          TempExcelBuffer.AddColumn(FORMAT(ConsumptionQty),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                          TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty*FGOutput,0.01,'=')-ConsumptionQty),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                        END ELSE BEGIN
                        //IF MfgItem THEN
                        //  TempExcelBuffer.AddColumn(FORMAT(CalculateConsumption(BomComponent[Level-1]."No.",BomComponent[Level]."No.")),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number)
                        //ELSE
                         // ConsumptionQty :=CalculateConsumption(BomComponent[Level-1]."No.",BomComponent[Level]."No.");
                        //  TempExcelBuffer.AddColumn(FORMAT(CalculateConsumption(BomComponent[Level-1]."No.",BomComponent[Level]."No.")),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                          TempExcelBuffer.AddColumn(FORMAT(ROUND(BOMQty*FGOutput,0.01,'=')-ConsumptionQty),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                        END;
                        //IF Level>1 THEN
                        //TempExcelBuffer.AddColumn(FORMAT(BomComponent[Level].Quantity*BomComponent[Level-1].Quantity),FALSE,'',FALSE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Number);
                        */
                        Level := 1;
                        IF (Level = 1) AND (NOT MfgItem) THEN
                            TempExcelBuffer.AddColumn(FORMAT(CalculateConsumptionAmount(Item."No.", ComponentItem."No.")), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                        ELSE
                            TempExcelBuffer.AddColumn(FORMAT(0), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(FORMAT('Substitute Item'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.NewRow;
                    END;
                    ItemAmount.NEXT;
                    Counta -= 1;
                    IF Counta <= 0 THEN
                        CurrReport.BREAK;

                end;

                trigger OnPreDataItem()
                var
                    ItemLedgEntry: Record "Item Ledger Entry";
                begin
                    /*
                    ItemLedgEntry.SETCURRENTKEY("Source Type","Source No.","Entry Type","Item No.","Variant Code","Posting Date");
                    ItemLedgEntry.SETFILTER(ItemLedgEntry."Source No.",Item."No.");
                    ItemLedgEntry.SETRANGE("Posting date",FromDAte,Calculatedate);
                       */
                    ItemAmount.RESET;
                    ItemAmount.SETFILTER(ItemAmount.Quantity, '%1', 1);
                    IF ItemAmount.FINDFIRST THEN
                        Counta := ItemAmount.COUNT;
                    SETRANGE(Number, 1, Counta);

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT ProdBOM.GET(Item."Production BOM No.") THEN
                    CurrReport.SKIP;

                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Dimension Code", 'SIZE');
                DimVal.SETRANGE(DimVal.Code, Item."Size Code");
                IF DimVal.FINDFIRST THEN;

                FGOutput := 0;
                FGOutput := CalculateOutput(Item."No.");

                IF IncludeOnlyProduceItems THEN
                    IF FGOutput = 0 THEN
                        CurrReport.SKIP;

                ItemAmount.RESET;
                IF ItemAmount.FINDFIRST THEN
                    ItemAmount.DELETEALL;

                GenerateTempDatafromILE();
            end;

            trigger OnPreDataItem()
            begin
                ItemFilter := GETFILTERS;
                //SETFILTER("No.",'020206331850565011D');
                SETFILTER("Production BOM No.", '<>%1', '');
                IF SizeCode <> '' THEN
                    SETFILTER("Size Code", '%1', SizeCode);
                TempExcelBuffer.INIT;
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(FORMAT('From Date-'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(FromDate), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('To Date-'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(CalculateDate), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.NewRow;
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn(FORMAT('AS PER BOM'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn(FORMAT('Size'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('Posting Group'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('FG Code'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('RM Code'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('FG Output'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                //TempExcelBuffer.AddColumn(FORMAT('Other Output'),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn(FORMAT('RM Description'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('UOM'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                //TempExcelBuffer.AddColumn(FORMAT('PerQty'),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('BOM Qty'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('Expected Qty'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                //MS
                TempExcelBuffer.AddColumn(FORMAT('Expected cost at Bom qty'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                //MS
                TempExcelBuffer.AddColumn(FORMAT('Actual Consumption Qty'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('Difference'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                //MS

                TempExcelBuffer.AddColumn(FORMAT('Expected cost at Actual Qty'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('Difference in expected cost'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                //MS
                TempExcelBuffer.AddColumn(FORMAT('Cost Amount(Actual)'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(FORMAT('Type'), FALSE, '', TRUE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.NewRow;
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
                    Caption = 'Options';
                    field("Size "; SizeCode)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            InventorySetup: Record "Inventory Setup";
                            DimensionValue: Record "Dimension Value";
                        begin
                            InventorySetup.GET;
                            DimensionValue.RESET;
                            DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Size Code");
                            IF PAGE.RUNMODAL(Page::"Dimension Value List", DimensionValue) = ACTION::LookupOK THEN
                                SizeCode := DimensionValue.Code;
                        end;
                    }
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field(CalculateDate; CalculateDate)
                    {
                        Caption = 'To date';
                        ApplicationArea = All;
                    }
                    field("Include only Prod. Items"; IncludeOnlyProduceItems)
                    {
                        ApplicationArea = All;
                    }
                    field("Multi-Level"; MultiLevel)
                    {
                        Visible = false;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalculateDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IncludeOnlyProduceItems := TRUE;
    end;

    trigger OnPostReport()
    begin
        CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        IF TempExcelBuffer.FINDFIRST THEN
            TempExcelBuffer.DELETEALL;
    end;

    var
        Text000: Label 'As of ';
        ProdBOM: Record "Production BOM Header";
        BomComponent: array[99] of Record "Production BOM Line";
        CompItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        ItemFilter: Text;
        CalculateDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[15];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        Level: Integer;
        NextLevel: Integer;
        BOMQty: Decimal;
        Item: Record Item;
        QtyExplosionofBOMCaptLbl: Label 'Expected Vs.Actual ';
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Total Quantity';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        BomCompLevelUOMCodeCaptLbl: Label 'Unit of Measure Code';
        NoListType: array[99] of Option " ",Item,"Production BOM";
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExportToExcel: Boolean;
        DimVal: Record "Dimension Value";
        FromDate: Date;
        MfgItem: Boolean;
        MultiLevel: Boolean;
        FGOutput: Decimal;
        ConsumptionQty: Decimal;
        ItemAmount: Record "Item Amount" temporary;
        Counta: Integer;
        IncludeOnlyProduceItems: Boolean;
        SizeCode: Code[15];

    local procedure CreateExcelbook()
    begin

        // TempExcelBuffer.CreateBookAndOpenExcel('BOMVS', 'DEF', COMPANYNAME, USERID, '');

        // TempExcelBuffer.CreateBookAndOpenExcel('GSTR1', 'GST Return', COMPANYNAME, USERID, '');
        //16225  TempExcelBuffer.GiveUserControl;
        TempExcelBuffer.CreateNewBook('BOMVS');
        TempExcelBuffer.WriteSheet('DEF', CompanyName, UserId);
        // TempExcelBuffer.SetFriendlyFilename();
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;



    procedure CalculateConsumption(FGCode: Code[20]; RMCode: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        ItemLedgerEntry.SETRANGE("Source No.", FGCode);
        ItemLedgerEntry.SETRANGE("Item No.", RMCode);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, CalculateDate);
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        EXIT(-1 * Qty);
    end;

    procedure CalculateOutput(FGCode: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SETRANGE("Item No.", FGCode);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, CalculateDate);
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
    end;

    procedure GenerateTempDatafromILE()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Item: Record Item;
    begin
        ItemLedgEntry.SETCURRENTKEY("Source Type", "Source No.", "Entry Type", "Item No.", "Variant Code", "Posting Date");
        ItemLedgEntry.SETFILTER("Source No.", Item."No.");
        ItemLedgEntry.SETRANGE("Posting Date", FromDate, CalculateDate);
        IF ItemLedgEntry.FINDFIRST THEN
            REPEAT
                GenerateTempData(ItemLedgEntry."Item No.");
            UNTIL ItemLedgEntry.NEXT = 0;
    end;

    procedure GenerateTempData(Itemno: Code[20])
    begin
        ItemAmount.RESET;
        ItemAmount.SETFILTER("Item No.", '%1', Itemno);
        IF NOT ItemAmount.FINDFIRST THEN BEGIN
            ItemAmount."Item No." := Itemno;
            ItemAmount.Quantity := 1;
            ItemAmount.INSERT;
        END;
    end;


    procedure CalculateConsumptionAmount(FGCode: Code[20]; RMCode: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry Type", '%1', ItemLedgerEntry."Entry Type"::Consumption);
        ItemLedgerEntry.SETFILTER("Source No.", '%1', FGCode);
        ItemLedgerEntry.SETFILTER("Item No.", '%1', RMCode);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, CalculateDate);
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                Qty += ItemLedgerEntry."Cost Amount (Actual)";
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        EXIT(-1 * Qty);
    end;
}

