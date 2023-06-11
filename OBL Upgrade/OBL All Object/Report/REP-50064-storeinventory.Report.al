report 50064 "store inventory"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\storeinventory.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("Inventory Posting Group")
                                ORDER(Ascending)
                                WHERE("Inventory Posting Group" = FILTER(<> 0));
            RequestFilterFields = "No.", "Inventory Posting Group", "Item Category Code",/* "Product Group Code",*/ "Gen. Prod. Posting Group", "Location Filter";
            column(CompanyName1; CompanyName1)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(ToDAte; ToDAte)
            {
            }
            column(SNo; SNo)
            {
            }
            column(No; Item."No.")
            {
            }
            column(Desc1; Item.Description)
            {
            }
            column(Desc2; Item."Description 2")
            {
            }
            column(BUOM; Item."Base Unit of Measure")
            {
            }
            column(UnitM; UnitM)
            {
            }
            column(OpeningQty; OpeningQty)
            {
            }
            column(OpeningAmt; OpeningAmt)
            {
            }
            column(RcptQty; RcptQty)
            {
            }
            column(RcptAmount; RcptAmt)
            {
            }
            column(TotalRcptQty; TotalRcptQty)
            {
            }
            column(TotalRcptAmt; TotalRcptAmt)
            {
            }
            column(ConAdjQty; ConAdjQty)
            {
            }
            column(ConAdjAmt; ConAdjAmt)
            {
            }
            column(InConsumption; InConsumption)
            {
            }
            column(InConsumptionAmt; InConsumptionAmt)
            {
            }
            column(AdjQty; AdjQty)
            {
            }
            column(AdjAmt; AdjAmt)
            {
            }
            column(ClosingQty; ClosingQty)
            {
            }
            column(ClosingAmt; ClosingAmt)
            {
            }
            column(ShelfNo_Item; SELF)
            {
            }
            column(ItemFilters; ItemFilters)
            {
            }
            column(InventoryPosGroup; Item."Inventory Posting Group")
            {
            }
            column(Summary; Summary)
            {
            }
            column(Avgconsumption; Avgconsumption)
            {
            }
            column(AvgConsuAmt; AvgConsuAmt)
            {
            }
            column(SearchDes; "Search Description")
            {
            }
            column(RecptAmtExp; RecptAmtExp)
            {
            }

            trigger OnAfterGetRecord()
            begin


                CLEAR(TotOutput);
                IF Summary THEN
                    IF NOT Once THEN BEGIN
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Plant Code", "Entry Type", "Posting Date", "Relational Location Code");
                        ItemLedgEntry.SETFILTER("Entry Type", '%1|%2', "Entry Type"::Output, "Entry Type"::Consumption);
                        ItemLedgEntry.SETRANGE("Posting Date", FromDate, ToDAte);
                        ItemLedgEntry.SETRANGE("Quality Code", '1');
                        ItemLedgEntry.SETFILTER("Item Category Code", '%1|%2|%3', 'M001', 'D001', 'H001');
                        ItemLedgEntry.SETFILTER("Re Process Production Order", '%1', FALSE);
                        ItemLedgEntry.SETFILTER("Document No.", '%1', 'RPO*');
                        ItemLedgEntry.SETFILTER("Location Code", LocationFilter);
                        IF ItemLedgEntry.FINDFIRST THEN BEGIN
                            REPEAT
                                //ItemLedgEntry.CALCSUMS(ItemLedgEntry."Qty in Sq.Mt.");
                                //   TotOutPut += ItemLedgEntry.Quantity;
                                TotOutput += ItemLedgEntry."Qty in Sq.Mt.";
                            UNTIL ItemLedgEntry.NEXT = 0;
                        END;
                    END;


                j += 1;
                RcptAmount := 0;
                OpeningQty := 0;
                OpeningAmt := 0;
                RcptQty := 0;
                RcptAmt := 0;
                AdjAmt := 0;
                AdjQty := 0;
                TotalRcptQty := 0;
                TotalRcptAmt := 0;
                TotRecptAmtExp := 0;
                RecptAmtExp := 0;
                ConQty := 0;
                ConAmt := 0;
                ClosingQty := 0;
                ClosingAmt := 0;
                EquiDays := 0;
                ConAdjAmt := 0;
                ConAdjQty := 0;
                Avgconsumption := 0; //sash
                AvgConsuAmt := 0;// sash
                NA := '';
                DateFilter1 := FORMAT(0D) + '..' + FORMAT(FromDate - 1);
                DateFilter2 := FORMAT(FromDate) + '..' + FORMAT(ToDAte);

                Win.UPDATE(1, ROUND(j / i * 10000, 1));
                //calculation of opening amount + Qty
                ILE.RESET;
                //ILE.SETCURRENTKEY("Item No.","Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                IF ILE.FINDFIRST THEN
                    UnitM := ILE."Unit of Measure Code";

                IF loccode = 'SKD-STORE' THEN
                    SELF := Item."Shelf No."
                ELSE
                    IF loccode = 'DRA-STORE' THEN
                        SELF := Item."Shelf Location Dra"
                    ELSE
                        IF loccode = 'HSK-STORE' THEN
                            SELF := Item."Shelf Location HSK";


                ILE.RESET;
                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                ILE.SETRANGE("Posting Date", 0D, FromDate - 1);
                IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                    ILE.SETFILTER(ILE."Location Code", Item.GETFILTER(Item."Location Filter"));
                IF Item.GETFILTER(Item."Item Category Code") <> '' THEN
                    ILE.SETRANGE("Item Category Code", Item.GETFILTER(Item."Item Category Code"));
                //IF Item.GETFILTER(Item."Product Group Code") <> '' THEN
                //  ILE.SETRANGE("Item Category Code", Item.GETFILTER(Item."Product Group Code"));
                IF Item.GETFILTER(Item."Gen. Prod. Posting Group") <> '' THEN
                    ILE.SETRANGE("Item Category Code", Item.GETFILTER(Item."Gen. Prod. Posting Group"));
                IF Item.GETFILTER(Item."Inventory Posting Group") <> '' THEN
                    ILE.SETFILTER(ILE."Inventory Posting Group", Item.GETFILTER(Item."Inventory Posting Group"));
                IF ILE.FIND('-') THEN
                    REPEAT
                        ILE.CALCFIELDS("Cost Amount (Actual)");
                        OpeningQty += ILE.Quantity;
                        OpeningAmt += ILE."Cost Amount (Actual)";
                    UNTIL ILE.NEXT = 0;
                //calculation of opening amount + Qty


                // sash
                RecItemLedgerEntry.RESET;
                //RecItemLedgerEntry.SETCURRENTKEY("Entry Type",Nonstock,"Item No.","Posting Date");
                //RecItemLedgerEntry.SETRANGE("Entry Type",RecItemLedgerEntry."Entry Type"::Consumption);
                RecItemLedgerEntry.SETRANGE("Item No.", "No.");
                RecItemLedgerEntry.SETRANGE("Posting Date", ConsumptionFromDate, ConsumptionToDate);

                IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                    RecItemLedgerEntry.SETFILTER(RecItemLedgerEntry."Location Code", Item.GETFILTER(Item."Location Filter"));
                IF Item.GETFILTER(Item."Item Category Code") <> '' THEN
                    RecItemLedgerEntry.SETFILTER("Item Category Code", Item.GETFILTER(Item."Item Category Code"));
                // 16630 IF Item.GETFILTER(Item."Product Group Code") <> '' THEN
                // 16630 RecItemLedgerEntry.SETFILTER("Item Category Code", Item.GETFILTER(Item."Product Group Code"));
                IF Item.GETFILTER(Item."Gen. Prod. Posting Group") <> '' THEN
                    RecItemLedgerEntry.SETFILTER("Item Category Code", Item.GETFILTER(Item."Gen. Prod. Posting Group"));
                IF Item.GETFILTER(Item."Inventory Posting Group") <> '' THEN
                    RecItemLedgerEntry.SETFILTER(RecItemLedgerEntry."Inventory Posting Group", Item.GETFILTER(Item."Inventory Posting Group"));

                IF RecItemLedgerEntry.FIND('-') THEN
                    REPEAT
                        IF (RecItemLedgerEntry."Entry Type" = RecItemLedgerEntry."Entry Type"::Consumption)
                        AND (NOT RecItemLedgerEntry."Re Process Production Order") THEN BEGIN
                            RecItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                            AvgConsuAmt += RecItemLedgerEntry."Cost Amount (Actual)";
                            Avgconsumption += RecItemLedgerEntry.Quantity;
                        END;

                    /*IF (RecItemLedgerEntry."Entry Type" = RecItemLedgerEntry."Entry Type"::"Negative Adjmt.")
                     AND (RecItemLedgerEntry."Direct Consumption Entries") THEN BEGIN
                      RecItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                      AvgConsuAmt += RecItemLedgerEntry."Cost Amount (Actual)";
                      Avgconsumption += RecItemLedgerEntry.Quantity;
                    END;
                    IF (RecItemLedgerEntry."Entry Type" = RecItemLedgerEntry."Entry Type"::Transfer)
                     AND (NOT RecItemLedgerEntry."External Transfer") THEN BEGIN
                      AvgConsuAmt += RecItemLedgerEntry."Cost Amount (Actual)";
                      Avgconsumption += RecItemLedgerEntry.Quantity;
                     END;*/
                    // Avgconsumption+=RecItemLedgerEntry.Quantity;
                    UNTIL
                         RecItemLedgerEntry.NEXT = 0;
                Avgconsumption := Avgconsumption / 3;
                AvgConsuAmt := AvgConsuAmt / 3;
                //sash

                ILE2.RESET;
                ILE2.SETCURRENTKEY("Item No.", "Posting Date");
                ILE2.SETRANGE("Item No.", "No.");
                ILE2.SETRANGE("Posting Date", FromDate, ToDAte);
                IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                    ILE2.SETFILTER("Location Code", Item.GETFILTER(Item."Location Filter"));
                IF Item.GETFILTER(Item."Item Category Code") <> '' THEN
                    ILE.SETRANGE("Item Category Code", Item.GETFILTER(Item."Item Category Code"));
                // 16630IF RecItem.GETFILTER(RecItem."Product Group Code") <> '' THEN
                // 16630 ILE.SETRANGE("Item Category Code", Item.GETFILTER(RecItem."Product Group Code"));
                IF Item.GETFILTER(Item."Gen. Prod. Posting Group") <> '' THEN
                    ILE.SETRANGE("Item Category Code", Item.GETFILTER(Item."Gen. Prod. Posting Group"));
                IF Item.GETFILTER(Item."Inventory Posting Group") <> '' THEN
                    ILE.SETRANGE(ILE."Inventory Posting Group", item.GETFILTER(Item."Inventory Posting Group"));
                IF ILE2.FIND('-') THEN
                    REPEAT
                        ILE2.CALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
                        if ILE2."Entry Type" = ILE2."Entry Type"::Purchase then begin
                            RcptQty += ILE2.Quantity;
                            RcptAmt += ILE2."Cost Amount (Actual)";
                            RecptAmtExp += ILE2."Cost Amount (Expected)";
                        END;
                        IF (ILE2."Entry Type" = ILE2."Entry Type"::Consumption) AND (NOT ILE2."Re Process Production Order") OR (ILE2."Entry Type" = ILE2."Entry Type"::"Assembly Consumption") THEN BEGIN
                            ConAmt += ILE2."Cost Amount (Actual)";
                            ConQty += ILE2.Quantity;
                        END;
                        IF (ILE2."Entry Type" = ILE2."Entry Type"::"Negative Adjmt.") AND (ILE2."Direct Consumption Entries") THEN BEGIN
                            ConAmt += ILE2."Cost Amount (Actual)";
                            ConQty += ILE2.Quantity;
                        END;
                        IF (ILE2."Entry Type" = ILE2."Entry Type"::Transfer) AND (NOT ILE2."External Transfer") OR (ILE2."Entry Type" = ILE2."Entry Type"::"Assembly Output") THEN BEGIN
                            InConsumptionAmt += ILE2."Cost Amount (Actual)";
                            InConsumption += ILE2.Quantity;
                        END;
                        IF (ILE2."Entry Type" = ILE2."Entry Type"::"Negative Adjmt.") AND (NOT ILE2."Direct Consumption Entries") THEN BEGIN
                            AdjAmt += (ILE2."Cost Amount (Actual)");
                            AdjQty += (ILE2.Quantity);
                        END;
                        IF (ILE2."Entry Type" = ILE2."Entry Type"::"Positive Adjmt.") THEN BEGIN
                            AdjAmt += (ILE2."Cost Amount (Actual)");
                            AdjQty += (ILE2.Quantity);
                        END;
                    UNTIL ILE2.NEXT = 0;

                TotalRcptQty := OpeningQty + RcptQty;
                TotalRcptAmt := OpeningAmt + RcptAmt;

                SalesQty := 0;
                SalesAmt := 0;
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("No.", Item."No.");
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
                //SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Location Code",'%1','Plant');
                SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Location Code", '%1', loccode);

                IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                    REPEAT
                        SalesQty += SalesInvoiceLine.Quantity;
                        SalesAmt += SalesInvoiceLine.Amount;
                    UNTIL SalesInvoiceLine.NEXT = 0;
                END;
                ConAdjQty := ConQty;
                ConAdjAmt := ConAmt;
                //ClosingQty := OpeningQty + RcptQty + ConQty + AdjQty + InConsumption + SalesQty;
                ClosingQty := OpeningQty + RcptQty + ConQty + AdjQty + InConsumption - SalesQty;
                //ClosingAmt := OpeningAmt + RcptAmt + ConAmt + AdjAmt + InConsumptionAmt+SalesAmt;
                ClosingAmt := OpeningAmt + RcptAmt + ConAmt + AdjAmt + InConsumptionAmt - SalesAmt;

                IF ConQty = 0 THEN BEGIN
                    NA := 'NA';
                    EquiDays := 0;
                END ELSE BEGIN
                    NA := '';
                    EquiDays := ((ToDAte - FromDate + 1) * ClosingQty) / ConQty;
                END;

            end;

            trigger OnPostDataItem()
            begin
                Win.CLOSE;
            end;

            trigger OnPreDataItem()
            begin

                SNo := 0;

                CurrReport.CREATETOTALS(OpeningQty, RcptQty, ConQty, TotalRcptQty, ClosingQty, EquiDays, ConAdjQty, AdjQty, AdjAmt);
                CurrReport.CREATETOTALS(OpeningAmt, ConAmt, RcptAmt, TotalRcptAmt, ClosingAmt, ConAdjAmt, InConsumption, InConsumptionAmt, RecptAmtExp);

                i := COUNT;
                IF NOT Summary THEN
                    IF Item.GETFILTER("Location Filter") = '' THEN
                        ERROR('Please Select Location Filter');


                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
                ItemFilters := Item.GETFILTERS;
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
                group(group)
                {
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDAte)
                    {
                        ApplicationArea = All;
                    }
                    field(Locations; Locations)
                    {
                        ApplicationArea = All;
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
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        /* //TMC::6823
        IF ExportToExcel THEN BEGIN
           ExcelBuff.CreateBook;
           ExcelBuff.CreateSheet('Stock Inventory','',COMPANYNAME,USERID);
           ExcelBuff.GiveUserControl;
        END;
        RepAuditMgt.CreateAudit(50064)
        */

    end;

    trigger OnPreReport()
    begin
        IF (FromDate = 0D) OR (ToDAte = 0D) THEN
            ERROR(Text001);
        //sash strt
        ConsumptionFromDate := CALCDATE('-3M', ToDAte);
        fromMonth := DATE2DMY(ConsumptionFromDate, 2);
        fromyear := DATE2DMY(ConsumptionFromDate, 3);
        toMonth := DATE2DMY(ToDAte, 2);
        toYear := DATE2DMY(ToDAte, 3);

        ConsumptionFromDate := DMY2DATE(1, fromMonth, fromyear);
        CASE toMonth OF
            1, 3, 5, 7, 8, 10, 12:
                ConsumptionToDate := DMY2DATE(31, toMonth, toYear);
            4, 6, 9, 11:
                ConsumptionToDate := DMY2DATE(30, toMonth, toYear);
            2:
                ConsumptionToDate := DMY2DATE(28, toMonth, toYear);
        //sash
        END;
        //MESSAGE('%1  %2',ConsumptionFromDate,ConsumptionToDate);
        //ERROR('');

        FilterString := 'From Date ' + FORMAT(FromDate) + ' To Date ' + FORMAT(ToDAte) + Item.GETFILTERS;

        Win.OPEN(tgText002);
        i := 0;
        j := 0;
        /*  //TMC::6823
        IF ExportToExcel THEN BEGIN
           ExcelBuff.DELETEALL;
           CLEAR(ExcelBuff);
           EnterCell(2,2,'Plant',TRUE,FALSE);
           EnterCell(2,3,FORMAT(LocationFilter),TRUE,FALSE);
        
           EnterCell(4,1,'S.No.',TRUE,FALSE);
           EnterCell(4,2,'Item Code',TRUE,FALSE);
           EnterCell(4,3,'Item/Unit/Inv. UOM',TRUE,FALSE);
           EnterCell(1,4,'Opening',TRUE,FALSE);
           EnterCell(2,4,'<------>',TRUE,FALSE);
           EnterCell(3,4,'Qty.',TRUE,FALSE);
           EnterCell(1,5,'Opening',TRUE,FALSE);
           EnterCell(2,5,'<------>',TRUE,FALSE);
           EnterCell(3,5,'Amount',TRUE,FALSE);
           EnterCell(1,6,'Reciept',TRUE,FALSE);
           EnterCell(2,6,'<------>',TRUE,FALSE);
           EnterCell(3,6,'Qty.',TRUE,FALSE);
           EnterCell(1,7,'Reciept',TRUE,FALSE);
           EnterCell(2,7,'<------>',TRUE,FALSE);
           EnterCell(3,7,'Amount',TRUE,FALSE);
           EnterCell(1,8,'Reciept',TRUE,FALSE);
           EnterCell(2,8,'<------>',TRUE,FALSE);
           EnterCell(3,8,'Amount (Expected)',TRUE,FALSE);
           EnterCell(1,9,'Total',TRUE,FALSE);
           EnterCell(2,9,'<------>',TRUE,FALSE);
           EnterCell(3,9,'Qty.',TRUE,FALSE);
           EnterCell(1,10,'Total',TRUE,FALSE);
           EnterCell(2,10,'<------>',TRUE,FALSE);
           EnterCell(3,10,'Amount',TRUE,FALSE);
           EnterCell(1,11,'Consumption',TRUE,FALSE);
           EnterCell(2,11,'Direct Consp',TRUE,FALSE);
           EnterCell(3,11,'Qty.',TRUE,FALSE);
           EnterCell(1,12,'Consumption',TRUE,FALSE);
           EnterCell(2,12,'Direct Consp',TRUE,FALSE);
           EnterCell(3,12,'Amount',TRUE,FALSE);
           EnterCell(1,13,' ',TRUE,FALSE);
           EnterCell(2,13,'Avg. Decreases',TRUE,FALSE);
           EnterCell(3,13,'Qty.(3 months)',TRUE,FALSE);
           EnterCell(2,14,'Avg. Decreases',TRUE,FALSE);
           EnterCell(3,14,'Amount (3 months)',TRUE,FALSE);
        
           EnterCell(2,15,'Intrnl Transfr',TRUE,FALSE);
           EnterCell(3,15,'Qty.',TRUE,FALSE);
           EnterCell(2,16,'Intrnl Transfr',TRUE,FALSE);
           EnterCell(3,16,'Amount',TRUE,FALSE);
           EnterCell(1,17,'Adjustment',TRUE,FALSE);
           EnterCell(2,17,'<------>',TRUE,FALSE);
           EnterCell(3,17,'Qty.',TRUE,FALSE);
           EnterCell(1,18,'Adjustment',TRUE,FALSE);
           EnterCell(2,18,'<------>',TRUE,FALSE);
           EnterCell(3,18,'Amount',TRUE,FALSE);
        
           EnterCell(1,19,'Closing',TRUE,FALSE);
           EnterCell(2,19,'<------>',TRUE,FALSE);
           EnterCell(3,19,'Qty.',TRUE,FALSE);
        
           EnterCell(1,20,'Closing',TRUE,FALSE);
           EnterCell(2,20,'<------>',TRUE,FALSE);
           EnterCell(3,20,'Amount',TRUE,FALSE);
        //   EnterCell(3,21,'Self No.',TRUE,FALSE);
        IF Summary THEN BEGIN
           EnterCell(3,21,'Issued Amt',TRUE,FALSE);
           EnterCell(3,22,'Output (Sq. Mtr)',TRUE,FALSE);
           EnterCell(3,23,'Rate / Sq. Mtr.',TRUE,FALSE);
        END;
           k:=5;
        END;
        */
        CASE Locations OF
            0:
                LocationFilter := 'SKD*';
            1:
                LocationFilter := 'HSK*';
            2:
                LocationFilter := 'DRA*';
        END;

        loccode := Item.GETFILTER("Location Filter");

    end;

    var
        RecItem: Record Item;
        ILE: Record "Item Ledger Entry";
        FromDate: Date;
        ToDAte: Date;
        OpeningQty: Decimal;
        OpeningAmt: Decimal;
        ClosingQty: Decimal;
        ClosingAmt: Decimal;
        RcptQty: Decimal;
        ConQty: Decimal;
        RcptAmt: Decimal;
        ConAmt: Decimal;
        Item1: Record Item;
        DateFilter1: Text[30];
        DateFilter2: Text[30];
        FilterString: Text[250];
        TotalRcptQty: Decimal;
        TotalRcptAmt: Decimal;
        SNo: Integer;
        Item2: Record Item;
        Item3: Record Item;
        InventoryPostingGroup: Record "Inventory Posting Group";
        InventoryPG: Text[50];
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        Summary: Boolean;
        EquiDays: Decimal;
        NA: Text[30];
        AdjQty: Decimal;
        AdjAmt: Decimal;
        ILE2: Record "Item Ledger Entry";
        RcptAmount: Decimal;
        ConAdjQty: Decimal;
        ConAdjAmt: Decimal;
        PhyAdjQty: Decimal;
        PhyAdjAmt: Decimal;
        InConsumption: Decimal;
        InConsumptionAmt: Decimal;
        Win: Dialog;
        i: Integer;
        j: Integer;
        CompanyName2: Text[100];
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesQty: Decimal;
        SalesAmt: Decimal;
        UnitM: Code[15];
        ExcelBuff: Record "Excel Buffer";
        ExportToExcel: Boolean;
        k: Integer;
        ConsumptionFromDate: Date;
        ConsumptionToDate: Date;
        fromMonth: Integer;
        toMonth: Integer;
        fromyear: Integer;
        toYear: Integer;
        Avgconsumption: Decimal;
        AvgConsuAmt: Decimal;
        RecItemLedgerEntry: Record "Item Ledger Entry";
        RepAuditMgt: Codeunit "Auto PDF Generate";
        RecptAmtExp: Decimal;
        TotRecptAmtExp: Decimal;
        Locations: Option SKD,Hoskote,Dora;
        LocationFilter: Text[50];
        TotOutput: Decimal;
        Once: Boolean;
        ItemLedgEntry: Record "Item Ledger Entry";
        Text001: Label 'From Date and To Date are mandatory on request form.';
        tgText002: Label 'Process @1@@@@@@@@@@@@@@@';
        ItemFilters: Text;
        loccode: Code[20];
        SELF: Text[20];

    procedure EnterCell()
    begin
    end;
}

