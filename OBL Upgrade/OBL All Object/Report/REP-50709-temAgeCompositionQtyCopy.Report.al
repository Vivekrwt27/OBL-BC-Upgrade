report 50709 "Item Age Composition Qty Copy"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;
    RDLCLayout = '.\ReportLayouts\ItemAgeCompositionQtyCopy.rdl';
    Caption = 'Item Age Composition - Qty.';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Type = CONST(Inventory));
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
            column(Summary; Summary)
            {
            }
            column(SizeCode; Item."Size Code")
            {
            }
            column(PackingCode; Item."Packing Code")
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TblCptnItemFilter; TABLECAPTION + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(Item2PeriodStartDate; FORMAT(PeriodStartDate[2] + 1))
            {
            }
            column(Item3PeriodStartDate; FORMAT(PeriodStartDate[3]))
            {
            }
            column(Item31PeriodStartDate; FORMAT(PeriodStartDate[3] + 1))
            {
            }
            column(Item4PeriodStartDate; FORMAT(PeriodStartDate[4]))
            {
            }
            column(Item41PeriodStartDate; FORMAT(PeriodStartDate[4] + 1))
            {
            }
            column(Item5PeriodStartDate; FORMAT(PeriodStartDate[5]))
            {
            }
            column(No_Item; "No.")
            {
            }
            column(ItemAgeCompositionQtyCaption; ItemAgeCompositionQtyCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(TotalInvtQtyCaption; TotalInvtQtyCaptionLbl)
            {
            }
            column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemNoCaption; ItemNoCaptionLbl)
            {
            }
            column(InvtQty1_ItemLedgEntry; InvtQty[1])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty2_ItemLedgEntry; InvtQty[2])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty3_ItemLedgEntry; InvtQty[3])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty4_ItemLedgEntry; InvtQty[4])
            {
                DecimalPlaces = 0 : 2;
            }
            column(InvtQty5_ItemLedgEntry; InvtQty[5])
            {
                DecimalPlaces = 0 : 2;
            }
            column(TotalInvtQty; TotalInvtQty)
            {
                DecimalPlaces = 0 : 2;
            }
            column(Desc_Item; Description)
            {
            }
            column(PrintLine; PrintLine)
            {
            }
            column(PackingName; PackingName)
            {
            }
            column(SizeName; SizeName)
            {
            }
            column(UOM; tgItemUnitOfMeasure."Qty. per Unit of Measure")
            {
            }
            column(BAseUOM; Item."Base Unit of Measure")
            {
            }

            trigger OnAfterGetRecord()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                PrintLine := FALSE;


                SizeName := '';
                PackingName := '';
                InventorySetup.GET;
                IF DimValue.GET(InventorySetup."Size Code", "Size Code") THEN
                    SizeName := DimValue.Name;
                IF DimValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                    PackingName := DimValue.Name;


                tgItemUnitOfMeasure.RESET;
                tgItemUnitOfMeasure.SETRANGE(tgItemUnitOfMeasure."Item No.", Item."No.");
                tgItemUnitOfMeasure.SETRANGE(tgItemUnitOfMeasure.Code, 'CRT');
                IF tgItemUnitOfMeasure.FIND('-') THEN;

                TotalInvtQty := 0;
                FOR i := 1 TO 5 DO
                    InvtQty[i] := 0;

                ItemLedgEntry.FilterLinesWithItemToPlan(Item, FALSE);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        PrintLine := TRUE;
                        TotalInvtQty := TotalInvtQty + ItemLedgEntry."Remaining Quantity";
                        FOR i := 1 TO 5 DO
                            IF (ItemLedgEntry."Posting Date" > PeriodStartDate[i]) AND (ItemLedgEntry."Posting Date" <= PeriodStartDate[i + 1]) THEN
                                InvtQty[i] := InvtQty[i] + ItemLedgEntry."Remaining Quantity";
                    UNTIL ItemLedgEntry.NEXT = 0;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(EndingDate; PeriodStartDate[5])
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF PeriodStartDate[5] = 0D THEN
                                ERROR(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength) = '' THEN
                                EVALUATE(PeriodLength, '<0D>');
                        end;
                    }
                    field(Summary; Summary)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodStartDate[5] = 0D THEN
                PeriodStartDate[5] := CALCDATE('<CM>', WORKDATE);
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //ERROR('Sorry cannot be executed');
    end;

    trigger OnPreReport()
    var
        NegPeriodLength: DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;

        PeriodStartDate[6] := 99991231D;//31129999D
        EVALUATE(NegPeriodLength, STRSUBSTNO('-%1', FORMAT(PeriodLength)));
        FOR i := 1 TO 3 DO
            PeriodStartDate[5 - i] := CALCDATE(NegPeriodLength, PeriodStartDate[6 - i]);
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemFilter: Text;
        InvtQty: array[6] of Decimal;
        PeriodStartDate: array[7] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        ItemAgeCompositionQtyCaptionLbl: Label 'Item Age Composition - Quantity';
        PageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        BeforeCaptionLbl: Label '...Before';
        TotalInvtQtyCaptionLbl: Label 'Inventory';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        SizeName: Text[100];
        InventorySetup: Record "Inventory Setup";
        DimValue: Record "Dimension Value";
        PackingName: Text[100];
        Summary: Boolean;
        tgItemUnitOfMeasure: Record "Item Unit of Measure";

    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;
}

