report 50233 "Item Ageing -Store and Spares"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ItemAgeingStoreandSpares.rdl';
    Caption = 'Item Ageing -Store and Spares';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem(location; 14)
        {
            DataItemTableView = SORTING(Code)
                                WHERE(Code = FILTER('SKD-STORE|HSK-STORE|DRA-STORE'));
            column(ItemWise; ItemWise)
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
            column(Item1PeriodStartDate; FORMAT(PeriodStartDate[1]))
            {
            }
            column(Item2PeriodStartDate; FORMAT(PeriodStartDate[2] - 1))
            {
            }
            column(Item21PeriodStartDate; FORMAT(PeriodStartDate[2]))
            {
            }
            column(Item3PeriodStartDate; FORMAT(PeriodStartDate[3] - 1))
            {
            }
            column(Item31PeriodStartDate; FORMAT(PeriodStartDate[3]))
            {
            }
            column(Item4PeriodStartDate; FORMAT(PeriodStartDate[4] - 1))
            {
            }
            column(Item41PeriodStartDate; FORMAT(PeriodStartDate[4]))
            {
            }
            column(Item5PeriodStartDate; FORMAT(PeriodStartDate[5] - 1))
            {
            }
            column(Item51PeriodStartDate; FORMAT(PeriodStartDate[5]))
            {
            }
            column(Item6PeriodStartDate; FORMAT(PeriodStartDate[6] - 1))
            {
            }
            column(Item61PeriodStartDate; FORMAT(PeriodStartDate[6]))
            {
            }
            column(Item7PeriodStartDate; FORMAT(PeriodStartDate[7] - 1))
            {
            }
            column(Item71PeriodStartDate; FORMAT(PeriodStartDate[7]))
            {
            }
            column(Item8PeriodStartDate; FORMAT(PeriodStartDate[8]))
            {
            }
            column(PrevItem1PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[1])))
            {
            }
            column(PrevItem2PeriodStartDate; FORMAT(CALCDATE('-CM', (PeriodStartDate[2] - 1))))
            {
            }
            column(PrevItem21PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[2])))
            {
            }
            column(PrevItem3PeriodStartDate; FORMAT(CALCDATE('-CM', (PeriodStartDate[3] - 1))))
            {
            }
            column(PrevItem31PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[3])))
            {
            }
            column(PrevItem4PeriodStartDate; FORMAT(CALCDATE('-CM', (PeriodStartDate[4] - 1))))
            {
            }
            column(PrevItem41PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[4])))
            {
            }
            column(PrevItem5PeriodStartDate; FORMAT(CALCDATE('-CM', (PeriodStartDate[5] - 1))))
            {
            }
            column(PrevItem51PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[5])))
            {
            }
            column(PrevItem6PeriodStartDate; FORMAT(CALCDATE('-CM', (PeriodStartDate[6] - 1))))
            {
            }
            column(PrevItem61PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[6])))
            {
            }
            column(PrevItem7PeriodStartDate; FORMAT(CALCDATE('-CM', (PeriodStartDate[6] - 1))))
            {
            }
            column(PrevItem71PeriodStartDate; FORMAT(CALCDATE('-CM', PeriodStartDate[7])))
            {
            }
            column(PrevItem8PeriodStartDate; FORMAT(PeriodStartDate[8]))
            {
            }
            column(Code_Location; Location.Code)
            {
            }
            dataitem("Inventory Posting Group"; 94)
            {
                DataItemTableView = WHERE(Group = CONST('STORES & SPARES'));
                column(Code_InventoryPostingGroup; "Inventory Posting Group".Code)
                {
                }
                dataitem(item; 27)
                {
                    DataItemLink = "Inventory Posting Group" = FIELD(Code);
                    DataItemTableView = SORTING("No.")
                                        WHERE(Type = CONST(Inventory));
                    RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Location Filter";
                    column(No_Item; "No.")
                    {
                    }
                    column(Desc_Item; Description)
                    {
                    }
                    column(UOM; "Base Unit of Measure")
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
                    dataitem("Item Ledger Entry Ageing Data"; 50063)
                    {
                        DataItemLink = "Item No." = FIELD("No.");
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
                        column(InvtQty6_ItemLedgEntry; InvtQty[6])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtQty7_ItemLedgEntry; InvtQty[7])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(TotalInvtQty; TotalInvtQty)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrintLine; PrintLine)
                        {
                        }
                        column(InvtVal1_ItemLedgEntry; InvtVal[1])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtVal2_ItemLedgEntry; InvtVal[2])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtVal3_ItemLedgEntry; InvtVal[3])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtVal4_ItemLedgEntry; InvtVal[4])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtVal5_ItemLedgEntry; InvtVal[5])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtVal6_ItemLedgEntry; InvtVal[6])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(InvtVal7_ItemLedgEntry; InvtVal[7])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(TotalInvtVal; TotalInvtVal)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrintLine := TRUE;
                            IF "Item Ledger Entry Ageing Data"."Remaining Quantity" <> 0 THEN BEGIN
                                TotalInvtQty := TotalInvtQty + "Item Ledger Entry Ageing Data"."Remaining Quantity";
                                TotalInvtVal := TotalInvtVal + "Item Ledger Entry Ageing Data"."Cost Amount- Prop.";
                                FOR i := 1 TO 7 DO
                                    IF ("Item Ledger Entry Ageing Data"."Posting Date" > PeriodStartDate[i + 1]) AND ("Item Ledger Entry Ageing Data"."Posting Date" <= PeriodStartDate[i]) THEN BEGIN
                                        InvtQty[i] := InvtQty[i] + "Item Ledger Entry Ageing Data"."Remaining Quantity";
                                        InvtVal[i] := InvtVal[i] + "Item Ledger Entry Ageing Data"."Cost Amount- Prop.";
                                    END;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Item Ledger Entry Ageing Data"."Ageing Date", CALCDATE('-CM', TODAY));
                        end;
                    }
                    dataitem(PreviousAgeingData; 50063)
                    {
                        column(PrevInvtQty1_ItemLedgEntry; PrevInvtQty[1])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtQty2_ItemLedgEntry; PrevInvtQty[2])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtQty3_ItemLedgEntry; PrevInvtQty[3])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtQty4_ItemLedgEntry; PrevInvtQty[4])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtQty5_ItemLedgEntry; PrevInvtQty[5])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtQty6_ItemLedgEntry; PrevInvtQty[6])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtQty7_ItemLedgEntry; PrevInvtQty[7])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevTotalInvtQty; PrevTotalInvtQty)
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevPrintLine; PrintLine)
                        {
                        }
                        column(PrevInvtVal1_ItemLedgEntry; PrevInvtVal[1])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtVal2_ItemLedgEntry; PrevInvtVal[2])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtVal3_ItemLedgEntry; PrevInvtVal[3])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtVal4_ItemLedgEntry; PrevInvtVal[4])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtVal5_ItemLedgEntry; PrevInvtVal[5])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtVal6_ItemLedgEntry; PrevInvtVal[6])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevInvtVal7_ItemLedgEntry; PrevInvtVal[7])
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(PrevTotalInvtVal; PrevTotalInvtVal)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrintLine := TRUE;
                            IF "Remaining Quantity" <> 0 THEN BEGIN
                                PrevTotalInvtQty := PrevTotalInvtQty + "Remaining Quantity";
                                PrevTotalInvtVal := PrevTotalInvtVal + "Cost Amount- Prop.";
                                FOR i := 1 TO 7 DO
                                    IF ("Posting Date" > CALCDATE(PeriodLength, PeriodStartDate[i + 1])) AND ("Posting Date" <= CALCDATE(PeriodLength, PeriodStartDate[i])) THEN BEGIN
                                        PrevInvtQty[i] := PrevInvtQty[i] + "Remaining Quantity";
                                        PrevInvtVal[i] := PrevInvtVal[i] + "Cost Amount- Prop.";
                                    END;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Ageing Date", CALCDATE(PeriodLength, CALCDATE('-CM', TODAY)));
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        ItemLedgEntry: Record 32;
                        RemQty: Decimal;
                        RemVal: Decimal;
                    begin
                        PrintLine := FALSE;
                        TotalInvtQty := 0;
                        TotalInvtVal := 0;
                        FOR i := 1 TO 7 DO BEGIN
                            InvtQty[i] := 0;
                            InvtVal[i] := 0;
                        END;


                        IF PrintLine THEN BEGIN
                            FOR i := 1 TO 8 DO BEGIN
                                ICQty[i] += InvtQty[i];
                                ICVal[i] += InvtVal[i];
                            END;
                            SNo += 1;
                        END;
                    end;

                    trigger OnPostDataItem()
                    begin
                        //CreateSummary;
                    end;

                    trigger OnPreDataItem()
                    begin
                        //Item.SETFILTER("Item Category Code",'%1',"Item Category".Code);
                        Item.SETFILTER("Location Filter", Location.Code);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TotalInvtQty := 0;
                    TotalInvtVal := 0;
                    FOR i := 1 TO 7 DO BEGIN
                        ICQty[i] := 0;
                        ICVal[i] := 0;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    FOR i := 1 TO 7 DO BEGIN
                        InvtQty[i] := 0;
                        InvtVal[i] := 0;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalInvtQty := 0;
                TotalInvtVal := 0;
                FOR i := 1 TO 7 DO BEGIN
                    ICQty[i] := 0;
                    ICVal[i] := 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                FOR i := 1 TO 7 DO BEGIN
                    InvtQty[i] := 0;
                    InvtVal[i] := 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                //CLEAR(ICQty);
                //CLEAR(ICVal);
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
                    field(EndingDate; PeriodStartDate[1])
                    {
                        Caption = 'Ending Date';

                        trigger OnValidate()
                        begin
                            IF PeriodStartDate[5] = 0D THEN
                                ERROR(Text002);
                        end;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Compare Period Length';

                        trigger OnValidate()
                        begin
                            IF FORMAT(PeriodLength) = '' THEN
                                EVALUATE(PeriodLength, '<0D>');
                        end;
                    }
                    field("Item Wise Detail"; ItemWise)
                    {
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
        PeriodCalc[1] := '1Q';
        PeriodCalc[2] := '1Q';
        PeriodCalc[3] := '2Q';  //MIPLRK 1Q to 2Q
        PeriodCalc[4] := '1Y';
        PeriodCalc[5] := '1Y';
        PeriodCalc[6] := '2Y';
        //PeriodCalc[7] := '2Y';
    end;

    trigger OnPostReport()
    begin
        //ExcelBuffer.CreateBookAndOpenExcel('Inventory Ageing','Inventory Ageing','Inventory Ageing Report',COMPANYNAME,USERID);
    end;

    trigger OnPreReport()
    var
        NegPeriodLength: array[7] of DateFormula;
    begin
        ItemFilter := Item.GETFILTERS;

        PeriodStartDate[8] := 0D;

        FOR i := 1 TO 6 DO
            EVALUATE(NegPeriodLength[i], STRSUBSTNO('-%1', FORMAT(PeriodCalc[i])));


        FOR i := 1 TO 6 DO
            PeriodStartDate[i + 1] := CALCDATE(NegPeriodLength[i], PeriodStartDate[i]);

        //CreateExcelHeader;
    end;

    var
        Text002: Label 'Enter the ending date';
        ItemFilter: Text;
        InvtQty: array[8] of Decimal;
        InvtVal: array[8] of Decimal;
        PeriodStartDate: array[9] of Date;
        PeriodLength: DateFormula;
        i: Integer;
        TotalInvtQty: Decimal;
        PrintLine: Boolean;
        ItemAgeCompositionQtyCaptionLbl: Label 'Item Age Composition - Quantity As on Date';
        PageNoCaptionLbl: Label 'Page';
        AfterCaptionLbl: Label 'After...';
        BeforeCaptionLbl: Label '...Before';
        TotalInvtQtyCaptionLbl: Label 'Inventory';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemNoCaptionLbl: Label 'Item No.';
        TotalInvtVal: Decimal;
        ExcelBuffer: Record "Excel Buffer" temporary;
        SNo: Integer;
        PeriodCalc: array[9] of Text;
        ICQty: array[9] of Decimal;
        ICVal: array[9] of Decimal;
        ItemWise: Boolean;
        PrevInvtQty: array[8] of Decimal;
        PrevInvtVal: array[8] of Decimal;
        PrevICQty: array[9] of Decimal;
        PrevICVal: array[9] of Decimal;
        PrevTotalInvtQty: Decimal;
        PrevTotalInvtVal: Decimal;
        PrevPeriodStartDate: array[9] of Date;
        PrevPeriodLength: DateFormula;
        j: Integer;
        PrevPeriodCalc: array[9] of Text;

    local procedure CreateExcelHeader()
    begin
        ExcelBuffer.AddColumn(' ', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(' Inventory Ageing Report ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Details', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('S.No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Item Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Item No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('UOM', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        FOR i := 1 TO 7 DO BEGIN
            ExcelBuffer.AddColumn('<--' + FORMAT(PeriodStartDate[i]), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            IF i = 7 THEN
                ExcelBuffer.AddColumn('and Above-->>', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text)
            ELSE
                ExcelBuffer.AddColumn(FORMAT(PeriodStartDate[i + 1] - 1) + '-->', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        END;
        ExcelBuffer.AddColumn('<<--Total -->>', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        /*
        ExcelBuffer.AddColumn('Period 1',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 2',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 3',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 4',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Period 5',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Period 6',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Period 7',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('After',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        */
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;

    end;

    local procedure ExcelData()
    begin
        ExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Inventory Posting Group".Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Location.Code, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Item.Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Item."Base Unit of Measure", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        FOR i := 1 TO 7 DO BEGIN
            ExcelBuffer.AddColumn(InvtQty[i], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);

            ExcelBuffer.AddColumn(InvtVal[i], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        END;

        ExcelBuffer.AddColumn(TotalInvtQty, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);

        ExcelBuffer.AddColumn(TotalInvtVal, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);


        ExcelBuffer.NewRow;
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewPeriodLength: DateFormula)
    begin
        PeriodStartDate[5] := NewEndingDate;
        PeriodLength := NewPeriodLength;
    end;

    local procedure CalcRemValue(RemQty: Decimal; TotQty: Decimal; CostAmtAct: Decimal; CostAmtExp: Decimal): Decimal
    begin
        IF (RemQty = 0) OR (TotQty = 0) THEN
            EXIT(0);
        EXIT(((CostAmtAct + CostAmtExp) / TotQty) * RemQty);
    end;

    local procedure CreateSummary()
    begin
        ExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Location.Code, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn("Inventory Posting Group".Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        FOR i := 1 TO 7 DO BEGIN
            ExcelBuffer.AddColumn(ICQty[i], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.AddColumn(ICVal[i], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        END;
        ExcelBuffer.NewRow;
    end;
}

