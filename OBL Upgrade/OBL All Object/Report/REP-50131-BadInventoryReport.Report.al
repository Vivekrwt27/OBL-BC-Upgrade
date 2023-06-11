report 50131 "Bad Inventory Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\BadInventoryReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = WHERE("Item Category Code" = FILTER('M001|D001|H001'),
                                      "Type Code" = FILTER('01|02'));
            RequestFilterFields = "Location Code";
            column(ShowDetails; ShowDetails)
            {
            }
            column(catcode; catcode)
            {
            }
            column(AsonDate; AsonDate)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemDescription; RecItem1."Complete Description")
            {
            }
            column(ItemManuf_Strategy; RecItem1."Manuf. Strategy")
            {
            }
            column(ItemType; RecItem1."Type Code Desc.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(SKD_FloorPrem; FloorPrem)
            {
            }
            column(SKD_FloorBad; FloorBad)
            {
            }
            column(SKD_FloorSTD; FloorSTD)
            {
            }
            column(SKD_WallPrem; WallPrem)
            {
            }
            column(SKD_WallBad; WallBad)
            {
            }
            column(SKD_WallSTD; WallSTD)
            {
            }
            column(DRA_FloorPrem; FloorPrem2)
            {
            }
            column(DRA_FloorBad; FloorBad2)
            {
            }
            column(DRA_FloorSTD; FloorSTD2)
            {
            }
            column(DRA_WallPrem; WallPrem2)
            {
            }
            column(DRA_WallBad; WallBad2)
            {
            }
            column(DRA_WallSTD; WallSTD2)
            {
            }
            column(HSK_FloorPrem; FloorPrem3)
            {
            }
            column(HSK_FloorBad; FloorBad3)
            {
            }
            column(HSK_FloorSTD; FloorSTD3)
            {
            }
            column(HSK_WallPrem; WallPrem3)
            {
            }
            column(HSK_WallBad; WallBad3)
            {
            }
            column(HSK_WallSTD; WallSTD3)
            {
            }
            column(Details_FloorPrem; FloorPrem4)
            {
            }
            column(Details_FloorBad; FloorBad4)
            {
            }
            column(Details_FloorSTD; FloorSTD4)
            {
            }
            column(Details_WallPrem; WallPrem4)
            {
            }
            column(Details_WallBad; WallBad4)
            {
            }
            column(Details_WallSTD; WallSTD4)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(FloorBad4);
                CLEAR(FloorPrem4);
                CLEAR(FloorSTD4);
                CLEAR(WallBad4);
                CLEAR(WallPrem4);
                CLEAR(WallSTD4);

                IF RecItem1.GET("Item Ledger Entry"."Item No.") THEN;

                //Summary>>>>>
                IF ShowDetails = FALSE THEN BEGIN
                    IF "Item Ledger Entry"."Item Category Code" = 'M001' THEN BEGIN
                        RecItem.RESET;
                        RecItem.SETRANGE("No.", "Item No.");
                        IF RecItem.FINDSET THEN
                            REPEAT
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem."Manuf. Strategy" <> RecItem."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorPrem += Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem."Manuf. Strategy" = RecItem."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorBad += Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" <> '1') THEN
                                    FloorSTD += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem."Manuf. Strategy" <> RecItem."Manuf. Strategy"::"Non Retained ") THEN
                                    WallPrem += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem."Manuf. Strategy" = RecItem."Manuf. Strategy"::"Non Retained ") THEN
                                    WallBad += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" <> '1') THEN
                                    WallSTD += Quantity;
                            UNTIL RecItem.NEXT = 0;
                    END;

                    IF "Item Ledger Entry"."Item Category Code" = 'D001' THEN BEGIN
                        RecItem2.RESET;
                        RecItem2.SETRANGE("No.", "Item No.");
                        IF RecItem2.FINDSET THEN
                            REPEAT
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem2."Manuf. Strategy" <> RecItem2."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorPrem2 += Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem2."Manuf. Strategy" = RecItem2."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorBad2 += Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" <> '1') THEN
                                    FloorSTD2 += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem2."Manuf. Strategy" <> RecItem2."Manuf. Strategy"::"Non Retained ") THEN
                                    WallPrem2 += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem2."Manuf. Strategy" = RecItem2."Manuf. Strategy"::"Non Retained ") THEN
                                    WallBad2 += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" <> '1') THEN
                                    WallSTD2 += Quantity;
                            UNTIL RecItem2.NEXT = 0;
                    END;

                    IF "Item Ledger Entry"."Item Category Code" = 'H001' THEN BEGIN
                        RecItem3.RESET;
                        RecItem3.SETRANGE("No.", "Item No.");
                        IF RecItem3.FINDSET THEN
                            REPEAT
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem3."Manuf. Strategy" <> RecItem3."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorPrem3 += Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem3."Manuf. Strategy" = RecItem3."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorBad3 += Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" <> '1') THEN
                                    FloorSTD3 += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem3."Manuf. Strategy" <> RecItem3."Manuf. Strategy"::"Non Retained ") THEN
                                    WallPrem3 += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem3."Manuf. Strategy" = RecItem3."Manuf. Strategy"::"Non Retained ") THEN
                                    WallBad3 += Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" <> '1') THEN
                                    WallSTD3 += Quantity;
                            UNTIL RecItem3.NEXT = 0;
                    END;
                END;

                //Details>>>>
                CLEAR(catcode);
                IF "Item Ledger Entry"."Item Category Code" = 'H001' THEN
                    catcode := 'HSK'
                ELSE
                    IF "Item Ledger Entry"."Item Category Code" = 'D001' THEN
                        catcode := 'DRA'
                    ELSE
                        IF "Item Ledger Entry"."Item Category Code" = 'M001' THEN
                            catcode := 'SKD';

                IF ShowDetails = TRUE THEN BEGIN
                    IF "Item Ledger Entry"."Item Category Code" = "Item Ledger Entry"."Item Category Code" THEN BEGIN
                        RecItem4.RESET;
                        RecItem4.SETRANGE("No.", "Item No.");
                        IF RecItem4.FINDSET THEN
                            REPEAT
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem4."Manuf. Strategy" <> RecItem4."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorPrem4 := Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" = '1') AND (RecItem4."Manuf. Strategy" = RecItem4."Manuf. Strategy"::"Non Retained ") THEN
                                    FloorBad4 := Quantity;
                                IF ("Type Code" = '01') AND ("Quality Code" <> '1') THEN
                                    FloorSTD4 := Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem4."Manuf. Strategy" <> RecItem4."Manuf. Strategy"::"Non Retained ") THEN
                                    WallPrem4 := Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" = '1') AND (RecItem4."Manuf. Strategy" = RecItem4."Manuf. Strategy"::"Non Retained ") THEN
                                    WallBad4 := Quantity;
                                IF ("Type Code" = '02') AND ("Quality Code" <> '1') THEN
                                    WallSTD4 := Quantity;
                            UNTIL RecItem4.NEXT = 0;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SETRANGE("Posting Date", 0D, AsonDate);
                CLEAR(FloorBad);
                CLEAR(FloorPrem);
                CLEAR(FloorSTD);
                CLEAR(WallBad);
                CLEAR(WallPrem);
                CLEAR(WallSTD);
                CLEAR(FloorBad2);
                CLEAR(FloorPrem2);
                CLEAR(FloorSTD2);
                CLEAR(WallBad2);
                CLEAR(WallPrem2);
                CLEAR(WallSTD2);
                CLEAR(FloorBad3);
                CLEAR(FloorPrem3);
                CLEAR(FloorSTD3);
                CLEAR(WallBad3);
                CLEAR(WallPrem3);
                CLEAR(WallSTD3);
                CLEAR(FloorBad4);
                CLEAR(FloorPrem4);
                CLEAR(FloorSTD4);
                CLEAR(WallBad4);
                CLEAR(WallPrem4);
                CLEAR(WallSTD4);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Report Date"; AsonDate)
                {
                    ApplicationArea = All;
                }
                field("Show Details"; ShowDetails)
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
        IF AsonDate = 0D THEN
            AsonDate := WORKDATE;
    end;

    var
        AsonDate: Date;
        RecItem: Record Item;
        RecItem1: Record Item;
        RecItem2: Record Item;
        RecItem3: Record Item;
        RecItem4: Record Item;
        RecILE: Record "Item Ledger Entry";
        FloorPrem: Decimal;
        FloorBad: Decimal;
        FloorSTD: Decimal;
        WallPrem: Decimal;
        WallBad: Decimal;
        WallSTD: Decimal;
        FloorPrem2: Decimal;
        FloorBad2: Decimal;
        FloorSTD2: Decimal;
        WallPrem2: Decimal;
        WallBad2: Decimal;
        WallSTD2: Decimal;
        FloorPrem3: Decimal;
        FloorBad3: Decimal;
        FloorSTD3: Decimal;
        WallPrem3: Decimal;
        WallBad3: Decimal;
        WallSTD3: Decimal;
        FloorPrem4: Decimal;
        FloorBad4: Decimal;
        FloorSTD4: Decimal;
        WallPrem4: Decimal;
        WallBad4: Decimal;
        WallSTD4: Decimal;
        ShowDetails: Boolean;
        catcode: Code[10];
}

