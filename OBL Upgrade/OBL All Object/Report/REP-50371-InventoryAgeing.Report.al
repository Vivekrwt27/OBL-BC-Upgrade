report 50371 "Inventory Ageing."
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\InventoryAgeing.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Location Code", "Item No.", "Variant Code", Open, Positive, "Posting Date")
                                WHERE(Quantity = FILTER(> 0));
            RequestFilterFields = "Location Code", "Item No.", "Item Category Code", "Item Base Unit of Measure";
            column(ItemGetFilters; "Item Ledger Entry".GETFILTERS)
            {
            }
            column(ColumnHead4; ColumnHead[4])
            {
            }
            column(ColumnHead9; ColumnHead[9])
            {
            }
            column(ColumnHead8; ColumnHead[8])
            {
            }
            column(ColumnHead7; ColumnHead[7])
            {
            }
            column(ColumnHead3; ColumnHead[3])
            {
            }
            column(ColumnHead2; ColumnHead[2])
            {
            }
            column(ColumnHead1; ColumnHead[1])
            {
            }
            column(ColumnHead6; ColumnHead[6])
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(CompName1; CompanyInfo.Name)
            {
            }
            column(CompName2; CompanyInfo."Name 2")
            {
            }
            column(Today; FORMAT(TODAY))
            {
            }
            column(ItemName; ItemName)
            {
            }
            column(ItemName2; ItemName2)
            {
            }
            column(ItemSize; ItemSize)
            {
            }
            column(ItemQuality; ItemQuality)
            {
            }
            column(QTyPerUOM; tgItemUnitOfMeasure."Qty. per Unit of Measure")
            {
            }
            column(UOMCode; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(ItemUMO; ItemUMO)
            {
            }
            column(Qty4; Qty[4])
            {
            }
            column(Qty7; Qty[7])
            {
            }
            column(Qty8; Qty[8])
            {
            }
            column(Qty9; Qty[9])
            {
            }
            column(Qty3; Qty[3])
            {
            }
            column(Qty2; Qty[2])
            {
            }
            column(Qty1; Qty[1])
            {
            }
            column(Qty6; Qty[6])
            {
            }
            column(LocQty4; LocQty[4])
            {
            }
            column(LocQty7; LocQty[7])
            {
            }
            column(LocQty8; LocQty[8])
            {
            }
            column(LocQty9; LocQty[9])
            {
            }
            column(LocQty3; LocQty[3])
            {
            }
            column(LocQty2; LocQty[2])
            {
            }
            column(LocQty1; LocQty[1])
            {
            }
            column(LocQty6; LocQty[6])
            {
            }
            column(GrLocQty4; GrLocQty[4])
            {
            }
            column(GrLocQty7; GrLocQty[7])
            {
            }
            column(GrLocQty8; GrLocQty[8])
            {
            }
            column(GrLocQty9; GrLocQty[9])
            {
            }
            column(GrLocQty3; GrLocQty[3])
            {
            }
            column(GrLocQty2; GrLocQty[2])
            {
            }
            column(GrLocQty1; GrLocQty[1])
            {
            }
            column(GrLocQty6; GrLocQty[6])
            {
            }
            column(TotalFor; TotalFor)
            {
            }
            column(PeriodEndDate; PeriodEndDate)
            {
            }
            column(ShowDetails; ShowDetails)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(AmountDue);
                CLEAR(Qty);
                CostPerUnit := 0;
                CostToGL := 0;
                GetRemQty;
                ActRectDate := "Posting Date";

                PrintLine := TRUE;

                IF ActRectDate IN [PeriodEndDate + 1 .. 99990101D] THEN BEGIN//Not Due// 01019999D]
                    Qty[5] := RemainingQty;
                END;
                IF ActRectDate IN [PeriodEndingDate[1] .. PeriodEndDate] THEN BEGIN
                    Qty[6] := RemainingQty;
                END;
                IF ActRectDate IN [PeriodEndingDate[2] .. PeriodEndingDate[1] - 1] THEN BEGIN
                    Qty[1] := RemainingQty;
                END;
                IF ActRectDate IN [PeriodEndingDate[3] .. PeriodEndingDate[2] - 1] THEN BEGIN
                    Qty[2] := RemainingQty;
                END;
                IF ActRectDate IN [PeriodEndingDate[4] .. PeriodEndingDate[3] - 1] THEN BEGIN
                    Qty[3] := RemainingQty;
                END;
                IF ActRectDate IN [PeriodEndingDate[4] - 60 .. PeriodEndingDate[4] - 1] THEN BEGIN
                    Qty[7] := RemainingQty;      //msnk
                END;
                IF ActRectDate IN [PeriodEndingDate[4] - 120 .. PeriodEndingDate[4] - 61] THEN BEGIN
                    Qty[8] := RemainingQty;      //msnk
                END;
                IF ActRectDate IN [PeriodEndingDate[4] - 180 .. PeriodEndingDate[4] - 121] THEN BEGIN
                    Qty[9] := RemainingQty;      //msnk
                END;
                IF ActRectDate IN [PeriodEndingDate[5] .. PeriodEndingDate[4] - 181] THEN BEGIN
                    Qty[4] := RemainingQty;
                END;

                ActRectDate := 0D;
                ColumnHead[6] := '0 - 30 Days';
                ColumnHead[1] := '31 - ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[2]) + 30) + 'Days';

                ColumnHead[2] := FORMAT((PeriodEndingDate[1] - PeriodEndingDate[2]) + 1 + 30) + '-' +
                                 FORMAT((PeriodEndingDate[1] - PeriodEndingDate[3]) + 30) + 'Days';

                ColumnHead[3] := FORMAT((PeriodEndingDate[1] - PeriodEndingDate[3]) + 1 + 30) + '-' +
                                 FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 30) + 'Days';

                ColumnHead[4] := 'Over ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 1 + 30) + 'Days';

                LocQty[1] := 0;
                LocQty[2] := 0;
                LocQty[3] := 0;
                LocQty[4] := 0;
                LocQty[5] := 0;
                LocQty[6] := 0;
                LocQty[7] := 0;
                LocQty[8] := 0;
                LocQty[9] := 0;

                tgItemUnitOfMeasure.RESET;
                tgItemUnitOfMeasure.SETRANGE(tgItemUnitOfMeasure."Item No.", "Item Ledger Entry"."Item No.");
                tgItemUnitOfMeasure.SETRANGE(tgItemUnitOfMeasure.Code, 'CRT');
                IF tgItemUnitOfMeasure.FIND('-') THEN;
                IF NOT cItem.GET("Item Ledger Entry"."Item No.") THEN BEGIN
                END ELSE
                    ItemName := cItem.Description;
                ItemName2 := cItem."Description 2";
                ItemSize := cItem."Size Code Desc.";
                ItemQuality := cItem."Quality Code Desc.";
                ItemUMO := cItem."Base Unit of Measure";

                LocQty[1] += Qty[1];
                LocQty[2] += Qty[2];
                LocQty[3] += Qty[3];
                LocQty[4] += Qty[4];
                LocQty[5] += Qty[5];
                LocQty[6] += Qty[6];
                LocQty[7] += Qty[7];
                LocQty[8] += Qty[8];
                LocQty[9] += Qty[9];

                LocDes := "Location Code";

                GrLocQty[1] := GrLocQty[1] + LocQty[1];
                GrLocQty[2] := GrLocQty[2] + LocQty[2];
                GrLocQty[3] := GrLocQty[3] + LocQty[3];
                GrLocQty[4] := GrLocQty[4] + LocQty[4];
                GrLocQty[5] := GrLocQty[5] + LocQty[5];
                GrLocQty[6] := GrLocQty[6] + LocQty[6];

                GrLocQty[7] := GrLocQty[7] + LocQty[7];
                GrLocQty[8] := GrLocQty[8] + LocQty[8];
                GrLocQty[9] := GrLocQty[9] + LocQty[9];
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item No.");
                ActRectDate := 0D;
                SETRANGE("Posting Date", 0D, PeriodEndDate);
                //16225 CurrReport.CREATETOTALS(AmountDue, RemainingQty, Qty);

                LocQty[1] := 0;
                LocQty[2] := 0;
                LocQty[3] := 0;
                LocQty[4] := 0;
                LocQty[5] := 0;
                LocQty[6] := 0;
                LocQty[7] := 0;
                LocQty[8] := 0;
                LocQty[9] := 0;

                CompanyInfo.GET();
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
                    field("Ending Date"; PeriodEndDate)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF PeriodEndDate = 0D THEN
                                ERROR(Text002);
                        end;
                    }
                    field("Period Length"; PeriodCalculation)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin


                            IF FORMAT(PeriodCalculation) = '' THEN
                                EVALUATE(PeriodCalculation, '<0D>');
                        end;
                    }
                    field(Summary; ShowDetails)
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
        PeriodCalculation := '30D';
    end;

    trigger OnPreReport()
    begin
        ItemFilter := "Item Ledger Entry".GETFILTERS;

        //new code insrt start
        PeriodEndingDate[1] := PeriodEndDate - 30;
        PeriodEndingDate[2] := PeriodEndDate - 60;

        FOR j := 3 TO 4 DO
            PeriodEndingDate[j] := CALCDATE('-(' + PeriodCalculation + ')', PeriodEndingDate[j - 1]);
        //MESSAGE('%1',PeriodEndingDate[j]);
        PeriodEndingDate[5] := 0D;
        ColumnHead[6] := '0 - 30 Days';
        ColumnHead[1] := '31 - ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[2]) + 30) + 'Days';

        ColumnHead[2] := FORMAT((PeriodEndingDate[1] - PeriodEndingDate[2]) + 1 + 30) + '-' +
                         FORMAT((PeriodEndingDate[1] - PeriodEndingDate[3]) + 30) + 'Days';

        ColumnHead[3] := FORMAT((PeriodEndingDate[1] - PeriodEndingDate[3]) + 1 + 30) + '-' +
                         FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 30) + 'Days';

        ColumnHead[7] := 'Over ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 1 + 30) + '-' +
                         FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 90) + 'Days';

        ColumnHead[8] := 'Over ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 91) + '-' +
                         FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 150) + 'Days';

        ColumnHead[9] := 'Over ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 151) + '-' +
                         FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 210) + 'Days';

        ColumnHead[4] := 'Over ' + FORMAT((PeriodEndingDate[1] - PeriodEndingDate[4]) + 1 + 210) + 'Days';

        LocQty[1] += Qty[1];
        LocQty[2] += Qty[2];
        LocQty[3] += Qty[3];
        LocQty[4] += Qty[4];
        LocQty[5] += Qty[5];
        LocQty[6] += Qty[6];
        LocQty[7] += Qty[7];
        LocQty[8] += Qty[8];
        LocQty[9] += Qty[9];
    end;

    var
        ItemUMO: Text[50];
        ItemFilter: Text[250];
        InvtQty: array[6] of Decimal;
        PeriodStartDate: array[7] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        CompanyInfo: Record "Company Information";
        SizeName: Text[100];
        InventorySetup: Record "Inventory Setup";
        DimValue: Record "Dimension Value";
        PackingName: Text[100];
        Summary: Boolean;
        tgItemUnitOfMeasure: Record "Item Unit of Measure";
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        StartDatem: Date;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ColumnHead: array[20] of Text[20];
        PeriodEndingDate: array[5] of Date;
        RunningAmount: Decimal;
        j: Integer;
        PeriodCalculation: Code[10];
        AmountDue: array[6] of Decimal;
        RemainingQty: Decimal;
        ActRectDate: Date;
        ActRectDate1: Date;
        cItem: Record Item;
        ShowDetails: Boolean;
        GroupFooterText: Text[100];
        CostToGL: Decimal;
        CostPerUnit: Decimal;
        Qty: array[12] of Decimal;
        ItemName: Text[50];
        ItemName2: Text[50];
        PeriodEndDate: Date;
        ItemSize: Text[65];
        ItemQuality: Text[50];
        LocQty: array[12] of Decimal;
        GrLocQty: array[12] of Decimal;
        LocDes: Text[50];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text002: Label 'Enter the ending date';
        Text1007: Label 'Stock Ageing Report';
        Text1001: Label 'For the Period';
        Text1000: Label 'Period: %1';
        Text1003: Label 'Data';
        Text1005: Label 'Company Name';
        Text1006: Label 'Report No.';
        Text1008: Label 'User ID';
        Text1009: Label 'Print Date';
        Text000: Label 'Document';
        TotalFor: Label 'Total for ';


    procedure GetRemQty()
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        RemainingQty := "Item Ledger Entry".Quantity;
        ItemApplicationEntry.RESET;
        ItemApplicationEntry.SETCURRENTKEY("Inbound Item Entry No.");
        ItemApplicationEntry.SETRANGE("Inbound Item Entry No.", "Item Ledger Entry"."Entry No.");
        ItemApplicationEntry.SETRANGE(ItemApplicationEntry."Posting Date", 20900101D, PeriodEndDate);//010190D
        IF ItemApplicationEntry.FIND('-') THEN
            REPEAT
                RemainingQty += ItemApplicationEntry.Quantity;
            UNTIL ItemApplicationEntry.NEXT = 0;

        RemainingQty := RemainingQty - "Item Ledger Entry".Quantity;
    end;

    procedure GetActRectDate(var ItemLedger: Record "Item Ledger Entry")
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin

        IF ItemLedger.Quantity > 0 THEN BEGIN
            ItemApplicationEntry.RESET;
            ItemApplicationEntry.SETCURRENTKEY("Inbound Item Entry No.");
            ItemApplicationEntry.SETRANGE("Inbound Item Entry No.", ItemLedger."Entry No.");
            ItemApplicationEntry.SETFILTER("Outbound Item Entry No.", '<%1', ItemLedger."Entry No.");
            IF ItemApplicationEntry.FIND('-') THEN BEGIN
                REPEAT
                    ItemLedgerEntry.GET(ItemApplicationEntry."Outbound Item Entry No.");
                    IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer THEN BEGIN
                        IF ActRectDate = 0D THEN BEGIN
                            GetActRectDate(ItemLedgerEntry);
                        END;
                    END
                    ELSE BEGIN
                        ActRectDate := ItemLedgerEntry."Posting Date";
                        EXIT;
                    END;
                    IF ActRectDate <> 0D THEN
                        EXIT;
                UNTIL ItemApplicationEntry.NEXT = 0;
            END;
        END;

        IF ItemLedger.Quantity < 0 THEN BEGIN
            ItemApplicationEntry.RESET;
            ItemApplicationEntry.SETCURRENTKEY("Outbound Item Entry No.");
            ItemApplicationEntry.SETRANGE("Outbound Item Entry No.", ItemLedger."Entry No.");
            ItemApplicationEntry.SETFILTER("Inbound Item Entry No.", '<%1', ItemLedger."Entry No.");
            IF ItemApplicationEntry.FIND('-') THEN BEGIN
                REPEAT
                    ItemLedgerEntry.GET(ItemApplicationEntry."Inbound Item Entry No.");
                    IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer THEN BEGIN
                        IF ActRectDate = 0D THEN
                            GetActRectDate(ItemLedgerEntry)
                    END
                    ELSE BEGIN
                        ActRectDate := ItemLedgerEntry."Posting Date";
                        EXIT;
                    END;
                    IF ActRectDate <> 0D THEN
                        EXIT;
                UNTIL ItemApplicationEntry.NEXT = 0;
            END;
        END;
    end;
}

