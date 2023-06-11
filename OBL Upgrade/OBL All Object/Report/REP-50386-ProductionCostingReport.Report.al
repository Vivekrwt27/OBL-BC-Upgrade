report 50386 "Production Costing Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ProductionCostingReport.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
                                WHERE("Entry Type" = FILTER(Output | Consumption),
                                      "Quality Code" = FILTER(1 | 2 | 3),
                                      "Item Category Code" = FILTER('M001' | 'D001' | 'H001'),
                                      "Document No." = FILTER('RPO*'));
            column(TotOutPut; TotOutPut)
            {
            }
            column(BodyValue; BodyValue)
            {
            }
            column(Filters; GETFILTERS + FORMAT('Location-') + FORMAT(Locations))
            {
            }
            column(FuelValue; FuelValue)
            {
            }
            column(GlazeValue; GlazeValue)
            {
            }
            column(StoreValue; StoreValue)
            {
            }
            column(PackMatValueAddColourValue; FORMAT(PackMatValue + ColourValue))
            {
            }
            column(LocaCode; "Location Code")
            {
            }
            column(ItemCode; "Item No.")
            {
            }
            column(DecTotal; recItem.Description + '-' + recItem."Description 2")
            {
            }
            column(ItemCatCode; "Item Category Code")
            {
            }
            column(BaseUOM; recItem."Base Unit of Measure")
            {
            }
            column(OutputQty; (OutputQty))
            {
            }
            column(TypeQty1; (TypeQty[1]))
            {
            }
            column(TypeQty2; (TypeQty[2]))
            {
            }
            column(TypeQty3; (TypeQty[3]))
            {
            }
            column(TypeQty4; (TypeQty[4]))
            {
            }
            column(TypeQty5; ((TypeQty[5])))
            {
            }
            column(TypeQty6; (TypeQty[6]))
            {
            }
            column(TypeQtyTotal; (TypeQty[1] + TypeQty[2] + TypeQty[3] + TypeQty[4] + TypeQty[5] + TypeQty[6]))
            {
            }
            column(ValueQty1; (ValueQty[1]))
            {
            }
            column(ValueQty2; (ValueQty[2]))
            {
            }
            column(ValueQty3; (ValueQty[3]))
            {
            }
            column(ValueQty4; (ValueQty[4]))
            {
            }
            column(AvgFuelMulOutputQty; (AvgFuel * OutputQty))
            {
            }
            column(AvgFuelTotal; AvgFuelTotal)
            {
            }
            column(AvgStoreMulOutputQty; (AvgStore * OutputQty))
            {
            }
            column(AvgStoreTotal; AvgStoreTotal)
            {
            }
            column(AvgBodyMulOutputQty; (AvgBody * OutputQty))
            {
            }
            column(AvgGlazeMulOutputQty; (AvgGlaze * OutputQty))
            {
            }
            column(AvgPackMatMulOutputQty; (AvgPackMat * OutputQty))
            {
            }
            column(AvgColorMatMulOutputQty; (AvgColour * OutputQty))
            {
            }
            column(Sumtotal; (ValueQty[1] + ValueQty[2] + ValueQty[3] + ValueQty[4] + (AvgFuel * OutputQty) + (AvgStore * OutputQty) + (AvgBody * OutputQty) + (AvgGlaze * OutputQty) + (AvgPackMat * OutputQty) + (AvgColour * OutputQty)))
            {
            }
            column(CostPerUnit; CostPerUnit)
            {
            }
            column(DimValueName; DimensionValue.Name)
            {
            }
            column(DimValueName1; DimensionValue1.Name)
            {
            }
            column(NewOutputQty; NewOutputQty)
            {
            }
            column(BodySum; BodyValue)
            {
            }
            column(BodyValSum; BodyValue + TotalBodyDirect)
            {
            }
            column(BodyValSum2; TotOutPut)
            {
            }
            column(GlazeSum; GlazeValue)
            {
            }
            column(GlazeValSum; GlazeValue + TotalGlazeDirect)
            {
            }
            column(ColourValSum; ColourValue)
            {
            }
            column(ColourValSum2; ColourValue + TotalColourDirect)
            {
            }
            column(PackingMat; PackMatValue)
            {
            }
            column(PackingMat2; PackMatValue + TotalPackMatDirect)
            {
            }
            column(TotalBodyDirect; TotalBodyDirect)
            {
            }
            column(TotalGlazeDirect; TotalGlazeDirect)
            {
            }
            column(TotalColourDirect; TotalColourDirect)
            {
            }
            column(TotalPackMatDirect; TotalPackMatDirect)
            {
            }

            trigger OnAfterGetRecord()
            var
                Int: Integer;
                ILE: Record "Item Ledger Entry";
                LastLineCheck: Boolean;
            begin
                IF recItem.GET("Item Ledger Entry"."Item No.") THEN;

                IF ItemGlob2 <> "Item Ledger Entry"."Item No." THEN BEGIN
                    TotalBodyDirect += ValueQty[1];
                    TotalGlazeDirect += ValueQty[2];
                    TotalColourDirect += ValueQty[3];
                    TotalPackMatDirect += ValueQty[4];

                    CLEAR(OutputQty);
                    FOR Int := 1 TO 6 DO BEGIN
                        CLEAR(TypeQty[Int]);
                        CLEAR(ValueQty[Int]);
                    END;
                END;

                NewOutputQty += Quantity;
                OutputQty += Quantity;
                ItemGlob2 := "Item Ledger Entry"."Item No.";
                ILE.COPY("Item Ledger Entry");
                IF ILE.NEXT <> 0 THEN
                    ItemGlob := ILE."Item No."
                ELSE
                    LastLineCheck := TRUE;
                IF (ItemGlob <> "Item Ledger Entry"."Item No.") OR LastLineCheck THEN BEGIN




                    IF TotOutPut <> 0 THEN BEGIN
                        AvgFuel := FuelValue / TotOutPut;
                        AvgFuelTotal += AvgFuel * OutputQty;  //MIPLRK2908
                        AvgStore := StoreValue / TotOutPut;
                        AvgStoreTotal += AvgStore * OutputQty;  //MIPLRK2908
                        AvgBody := BodyValue / TotOutPut;
                        AvgGlaze := GlazeValue / TotOutPut;
                        AvgPackMat := PackMatValue / TotOutPut;
                        AvgColour := ColourValue / TotOutPut;
                    END;

                    ItemLedgEntry.RESET;
                    ItemLedgEntry.SETCURRENTKEY("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date");
                    ItemLedgEntry.SETRANGE("Source No.", "Item No.");
                    ItemLedgEntry.SETRANGE("Posting Date", Startdate, EndDate);
                    ItemLedgEntry.SETFILTER("Location Code", LocationFilter);
                    ItemLedgEntry.SETFILTER(Quantity, '<0');
                    IF ItemLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            ItemLedgEntry.CALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)", "Inventory Posting Group");
                            CASE ItemLedgEntry."Inventory Posting Group" OF
                                'BODY':
                                    BEGIN
                                        TypeQty[1] -= ItemLedgEntry.Quantity;
                                        ValueQty[1] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'BODY-IMP':
                                    BEGIN
                                        TypeQty[1] -= ItemLedgEntry.Quantity;
                                        ValueQty[1] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'BODYPO':
                                    BEGIN
                                        TypeQty[1] -= ItemLedgEntry.Quantity;
                                        ValueQty[1] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'BODYSL':
                                    BEGIN
                                        TypeQty[1] -= ItemLedgEntry.Quantity;
                                        ValueQty[1] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                //GLAZE|GLAZE-IMP|WIP-GLAZE|WIP-PRINGT|WIP-ENGOBE
                                'GLAZE':
                                    BEGIN
                                        TypeQty[2] -= ItemLedgEntry.Quantity;
                                        ValueQty[2] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'GLAZE-IMP':
                                    BEGIN
                                        TypeQty[2] -= ItemLedgEntry.Quantity;
                                        ValueQty[2] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'FRIT':
                                    BEGIN
                                        TypeQty[2] -= ItemLedgEntry.Quantity;
                                        ValueQty[2] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;


                                'PRINGT':
                                    BEGIN
                                        TypeQty[2] -= ItemLedgEntry.Quantity;
                                        ValueQty[2] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'ENGOBE':
                                    BEGIN
                                        TypeQty[2] -= ItemLedgEntry.Quantity;
                                        ValueQty[2] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'COL':
                                    BEGIN
                                        TypeQty[3] -= ItemLedgEntry.Quantity;
                                        ValueQty[3] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'INK':
                                    BEGIN
                                        TypeQty[3] -= ItemLedgEntry.Quantity;
                                        ValueQty[3] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'INK-IMP':
                                    BEGIN
                                        TypeQty[3] -= ItemLedgEntry.Quantity;
                                        ValueQty[3] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'COL-IMP':
                                    BEGIN
                                        TypeQty[3] -= ItemLedgEntry.Quantity;
                                        ValueQty[3] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'PACK':
                                    BEGIN
                                        TypeQty[4] -= ItemLedgEntry.Quantity;
                                        ValueQty[4] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PACK-IMP':
                                    BEGIN
                                        TypeQty[4] -= ItemLedgEntry.Quantity;
                                        ValueQty[4] -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                            END;
                        UNTIL ItemLedgEntry.NEXT = 0;
                    END;

                    IF (OutputQty) <> 0 THEN
                        CostPerUnit := ((ValueQty[1] + ValueQty[2] + ValueQty[3] + ValueQty[4]) /
                            (OutputQty)) + (AvgFuel + AvgStore + AvgBody + AvgGlaze + AvgPackMat + AvgColour);


                    /*MESSAGE('%1  %2  %3  %4  %5  %6  %7  %8  %9  %10 ',
                    ValueQty[1],ValueQty[2],ValueQty[3],ValueQty[4],
                    OutputQty,AvgFuel,AvgStore,AvgBody,AvgGlaze,AvgPackMat);
                     */
                    DimensionValue.RESET;
                    IF DimensionValue.GET('SIZE', recItem."Size Code") THEN;


                    DimensionValue1.RESET;
                    IF DimensionValue1.GET('TYPE', recItem."Type Code") THEN;
                END;
                ItemGlob := "Item Ledger Entry"."Item No.";

            end;

            trigger OnPreDataItem()
            begin

                //"Item Ledger Entry".SETRANGE("Item No.",'015005648060218011M');
                SETRANGE("Posting Date", Startdate, EndDate);
                SETFILTER("Location Code", LocationFilter);
                Once := FALSE;
                CLEAR(OutputQty);
                CLEAR(TotOutPut);
                IF NOT Once THEN BEGIN
                    ItemLedgEntry.RESET;
                    ItemLedgEntry.SETCURRENTKEY("Plant Code", "Entry Type", "Posting Date", "Relational Location Code");
                    ItemLedgEntry.SETFILTER("Entry Type", '%1|%2', "Entry Type"::Output, "Entry Type"::Consumption);
                    ItemLedgEntry.SETRANGE("Posting Date", Startdate, EndDate);
                    ItemLedgEntry.SETRANGE("Quality Code", '1');
                    ItemLedgEntry.SETFILTER("Item Category Code", '%1|%2|%3', 'M001', 'D001', 'H001');
                    ItemLedgEntry.SETFILTER("Re Process Production Order", '%1', FALSE);
                    ItemLedgEntry.SETFILTER("Document No.", '%1', 'RPO*');
                    ItemLedgEntry.SETFILTER("Location Code", LocationFilter);
                    IF ItemLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            //ItemLedgEntry.CALCSUMS(ItemLedgEntry."Qty in Sq.Mt.");
                            //   TotOutPut += ItemLedgEntry.Quantity;
                            TotOutPut += ItemLedgEntry."Qty in Sq.Mt.";
                        UNTIL ItemLedgEntry.NEXT = 0;
                    END;

                    //Indirect Consumption
                    ItemLedgEntry.RESET;
                    ItemLedgEntry.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                    ItemLedgEntry.SETFILTER("Location Code", LocationFilter);
                    ItemLedgEntry.SETRANGE("Posting Date", Startdate, EndDate);
                    ItemLedgEntry.SETFILTER("Entry Type", '%1', "Entry Type"::Consumption);
                    //ItemLedgEntry.SETFILTER(Quantity,'<0');
                    IF ItemLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            ItemLedgEntry.CALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)", "Inventory Posting Group");
                            CASE ItemLedgEntry."Inventory Posting Group" OF
                                'FUEL':
                                    BEGIN
                                        FuelValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'GAS':
                                    BEGIN
                                        FuelValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'POWER':
                                    BEGIN
                                        FuelValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'ELEC':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'ELEC-IMP':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'GEN':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'MECH-IMP':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'MECH-IND':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PMIM':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PMIN':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'BLDG':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'CAPITAL':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'REF':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'MOTIF':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'SPIND':
                                    BEGIN
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                            END;
                        UNTIL ItemLedgEntry.NEXT = 0;
                    END;

                    ItemLedgEntry.RESET;
                    //ItemLedgEntry.SETCURRENTKEY("Item No.","Entry Type","Variant Code","Drop Shipment","Location Code","Posting Date");
                    ItemLedgEntry.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                    ItemLedgEntry.SETFILTER("Location Code", LocationFilter);
                    ItemLedgEntry.SETRANGE("Posting Date", Startdate, EndDate);
                    ItemLedgEntry.SETFILTER("Entry Type", '%1|%2', "Entry Type"::"Negative Adjmt.", "Entry Type"::"Positive Adjmt.");
                    //ItemLedgEntry.SETFILTER(Quantity,'<0');
                    IF ItemLedgEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            ItemLedgEntry.CALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)", "Inventory Posting Group");
                            CASE ItemLedgEntry."Inventory Posting Group" OF
                                'FUEL':
                                    BEGIN
                                        // TypeQty[5] -= ItemLedgEntry.Quantity;
                                        FuelValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'GAS':
                                    BEGIN
                                        // TypeQty[5] -= ItemLedgEntry.Quantity;
                                        FuelValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'POWER':
                                    BEGIN
                                        // TypeQty[5] -= ItemLedgEntry.Quantity;
                                        FuelValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'ELEC':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'ELEC-IMP':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'GEN':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'MECH-IMP':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'MECH-IND':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PMIM':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PMIN':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                //Kulbhushan Added New IPG START
                                'BLDG':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'CAPITAL':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'REF':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'MOTIF':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'SPIND':
                                    BEGIN
                                        // TypeQty[6] -= ItemLedgEntry.Quantity;
                                        StoreValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;


                                'BODY':
                                    BEGIN
                                        BodyValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'BODY-IMP':
                                    BEGIN
                                        BodyValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'GLAZE':
                                    BEGIN
                                        GlazeValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'GLAZE-IMP':
                                    BEGIN
                                        GlazeValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'FRIT':
                                    BEGIN
                                        GlazeValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'COL':
                                    BEGIN
                                        ColourValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'COL-IMP':
                                    BEGIN
                                        ColourValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'INK':
                                    BEGIN
                                        ColourValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'INK-IMP':
                                    BEGIN
                                        ColourValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;

                                'PACK':
                                    BEGIN
                                        PackMatValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PACK-IMP':
                                    BEGIN
                                        PackMatValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                                'PACKING':
                                    BEGIN
                                        PackMatValue -= ItemLedgEntry."Cost Amount (Actual)";
                                    END;
                            //Kulbhushan Added New IPG END
                            END;
                        UNTIL ItemLedgEntry.NEXT = 0;
                    END;
                    Once := TRUE;
                END;
                NewOutputQty := OutputQty;
                CLEAR(AvgFuelTotal);
                CLEAR(AvgStoreTotal);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Starting Date"; Startdate)
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field("Location Filter :"; Locations)
                {
                    ApplicationArea = All;
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

        CASE Locations OF
            0:
                LocationFilter := 'SKD*';
            1:
                LocationFilter := 'HSK*';
            2:
                LocationFilter := 'DRA*';
        END;
    end;

    var
        OutputQty: Decimal;
        TypeQty: array[10] of Decimal;
        ValueQty: array[10] of Decimal;
        ItemCat1: Text[30];
        ItemCat2: Text[30];
        ItemCat3: Text[30];
        ItemCat4: Text[30];
        ItemCat5: Text[30];
        ItemCat6: Text[30];
        ItemLedgEntry: Record "Item Ledger Entry";
        Startdate: Date;
        EndDate: Date;
        "--MSVRN": Integer;
        PrintToExcel: Boolean;
        ExcelBuffer: Record "Excel Buffer" temporary;
        Rowno: Integer;
        recItem: Record Item;
        CostPerUnit: Decimal;
        DimensionValue: Record "Dimension Value";
        RecIle: Record "Item Ledger Entry";
        AvgFuel: Decimal;
        AvgStore: Decimal;
        TotOutPut: Decimal;
        Once: Boolean;
        FuelValue: Decimal;
        StoreValue: Decimal;
        BodyValue: Decimal;
        GlazeValue: Decimal;
        ColourValue: Decimal;
        PackMatValue: Decimal;
        AvgBody: Decimal;
        AvgGlaze: Decimal;
        AvgColour: Decimal;
        AvgPackMat: Decimal;
        Locations: Option SKD,Hoskote,Dora;
        LocationFilter: Text[50];
        PrintSummary: Boolean;
        TotalFuelDirect: Decimal;
        TotalBodyDirect: Decimal;
        TotalColourDirect: Decimal;
        TotalPackMatDirect: Decimal;
        TotalGlazeDirect: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        DimensionValue1: Record "Dimension Value";
        ItemGlob: Code[30];
        NewOutputQty: Decimal;
        ItemGlob2: Code[30];
        AvgFuelTotal: Decimal;
        AvgStoreTotal: Decimal;
}

