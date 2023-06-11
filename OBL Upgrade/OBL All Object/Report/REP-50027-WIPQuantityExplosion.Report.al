report 50027 "WIP Quantity Explosion"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\WIPQuantityExplosion.rdl';
    Caption = 'WIP Quantity Explosion';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(TmpItemAmount; 268)
        {
            UseTemporary = true;
            dataitem(Item; 27)
            {
                DataItemTableView = SORTING("No.")
                                    WHERE("No." = FILTER('010101314590643040S'));
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
                column(Stock; TmpItemAmount.Quantity)
                {
                }
                column(LocCode; TmpItemAmount."Location Code")
                {
                }
                column(No_Item; TmpItemAmount."RM Item No.")
                {
                }
                column(Desc_Item; TmpItemAmount.Description)
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
                dataitem(BOMLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(Integer; 2000000026)
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
                            // DecimalPlaces = 0 : 5;
                        }
                        column(InvStock; Stock)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            BOMQty := Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
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
                        Stock := 0;
                        WHILE BomComponent[Level].NEXT = 0 DO BEGIN
                            Level := Level - 1;
                            IF Level < 1 THEN
                                CurrReport.BREAK;
                        END;

                        NextLevel := Level;
                        CLEAR(CompItem);
                        QtyPerUnitOfMeasure := 1;
                        CASE BomComponent[Level].Type OF
                            BomComponent[Level].Type::Item:
                                BEGIN
                                    CompItem.GET(BomComponent[Level]."No.");
                                    IF CompItem."Production BOM No." <> '' THEN BEGIN
                                        ProdBOM.GET(CompItem."Production BOM No.");
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
                                    Stock := GetInventoryStock(BomComponent[Level]."No.", TmpItemAmount."Location Code");
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
                                    VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.", CalculateDate, TRUE);
                                    BomComponent[NextLevel].SETRANGE("Production BOM No.", NoList[NextLevel]);
                                    BomComponent[NextLevel].SETRANGE("Version Code", VersionCode[NextLevel]);
                                    BomComponent[NextLevel].SETFILTER("Starting Date", '%1|..%2', 0D, CalculateDate);
                                    BomComponent[NextLevel].SETFILTER("Ending Date", '%1|%2..', 0D, CalculateDate);
                                    Stock := GetInventoryStock(BomItem."No.", TmpItemAmount."Location Code");
                                END;
                        END;

                        IF NextLevel <> Level THEN
                            Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                    end;

                    trigger OnPreDataItem()
                    begin
                        Level := 1;

                        ProdBOM.GET(TmpItemAmount."RM Item No.");

                        VersionCode[Level] := VersionMgt.GetBOMVersion(TmpItemAmount."RM Item No.", CalculateDate, TRUE);
                        CLEAR(BomComponent);
                        BomComponent[Level]."Production BOM No." := TmpItemAmount."RM Item No.";
                        BomComponent[Level].SETRANGE("Production BOM No.", TmpItemAmount."RM Item No.");
                        BomComponent[Level].SETRANGE("Version Code", VersionCode[Level]);
                        BomComponent[Level].SETFILTER("Starting Date", '%1|..%2', 0D, CalculateDate);
                        BomComponent[Level].SETFILTER("Ending Date", '%1|%2..', 0D, CalculateDate);
                        NoListType[Level] := NoListType[Level] ::Item;
                        NoList[Level] := TmpItemAmount."RM Item No.";
                        Quantity[Level] := TmpItemAmount.Quantity;
                        /*
                          UOMMgt.GetQtyPerUnitOfMeasure(Item,Item."Base Unit of Measure") /
                          UOMMgt.GetQtyPerUnitOfMeasure(
                            Item,
                            VersionMgt.GetBOMUnitOfMeasure(
                              TmpItemAmount."RM Item No.",VersionCode[Level]));
                              */

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Item."Production BOM No." := TmpItemAmount."RM Item No.";
                end;

                trigger OnPreDataItem()
                begin
                    //ItemFilter := GETFILTERS;
                    //SETFILTER("Production BOM No.",'<>%1','');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //MESSAGE(TmpItemAmount."RM Item No.");
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
                    field(CalculateDate; CalculateDate)
                    {
                        Caption = 'Calculation Date';
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
        CalculateDate := TODAY;
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
        VersionCode: array[99] of Code[20];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        Level: Integer;
        NextLevel: Integer;
        BOMQty: Decimal;
        QtyExplosionofBOMCaptLbl: Label 'WIP Raw Material Report';
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Total Quantity';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        BomCompLevelUOMCodeCaptLbl: Label 'Unit of Measure Code';
        NoListType: array[99] of Option " ",Item,"Production BOM";
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
        Stock: Decimal;

    procedure SetTableRecords(var ItemAmount: Record "Item Amount")
    begin
        IF ItemAmount.FIND('-') THEN
            REPEAT
                TmpItemAmount := ItemAmount;
                TmpItemAmount.INSERT;
            UNTIL ItemAmount.NEXT = 0;
    end;

    local procedure GetInventoryStock(ITemNo: Code[20]; LocationFilter: Code[20]): Decimal
    var
        Item: Record Item;
    begin
        IF ITemNo = '' THEN EXIT;
        Item.RESET;
        Item.SETFILTER("No.", '%1', ITemNo);
        Item.SETFILTER("Location Filter", LocationFilter);
        IF Item.FINDFIRST THEN BEGIN
            Item.CALCFIELDS(Inventory);
            EXIT(Item.Inventory);
        END;
    end;
}

