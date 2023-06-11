report 50060 "Production Planing"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ProductionPlaning.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Quality Code" = CONST('1'),
                                      "Item Category Code" = FILTER('D001 | M001 | H001'),
                                      Blocked = FILTER(false));
            RequestFilterFields = "No.";
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(SizeCodeDesc_Item; Item."Size Code Desc.")
            {
            }
            column(ManufStrategy_Item; Item."Manuf. Strategy")
            {
            }
            column(decDraWmd; ABS(decDraWmd))
            {
            }
            column(decSkdWmd; ABS(decSkdWmd))
            {
            }
            column(decHskWmd; ABS(decHskWmd))
            {
            }
            column(decDraStock; ABS(decDraStock))
            {
            }
            column(decSkdStock; ABS(decSkdStock))
            {
            }
            column(decHskStock; ABS(decHskStock))
            {
            }
            column(decPendOrdDra; ABS(decPendOrdDra))
            {
            }
            column(decPendOrdSkd; ABS(decPendOrdSkd))
            {
            }
            column(decPendOrdHsk; ABS(decPendOrdHsk))
            {
            }
            column(decGITDra; ABS(decGITDra))
            {
            }
            column(decGITHsk; ABS(decGITHsk))
            {
            }
            column(decGITSkd; ABS(decGITSkd))
            {
            }
            column(Created_date; Item."Created Date")
            {
            }
            column(LMSale; LMSale)
            {
            }
            column(LMProduction; LMProduction)
            {
            }
            column(LastProdDate; LastProdDate)
            {
            }
            column(LMSaleTotal; LMSaleTotal)
            {
            }
            column(LMProductionTotal; LMProductionTotal)
            {
            }
            column(Manufact_Name; Item."Manufacturer Name")
            {
            }
            column(NPD; Item.NPD)
            {
            }
            column(Item_class; Item."Item Classification")
            {
            }

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                //Var Initialization>>
                decDraStock := 0;
                decSkdStock := 0;
                decHskStock := 0;
                decDraWmd := 0;
                decSkdWmd := 0;
                decHskWmd := 0;
                decGITDra := 0;
                decGITHsk := 0;
                decGITSkd := 0;
                decPendOrdDra := 0;
                decPendOrdHsk := 0;
                decPendOrdSkd := 0;
                //Var Initialization<<

                //WMD Calculation>>
                // decDraWmd := GenerateItemAmtLine(Item,'DRA-WH-MFG',StartDate,EndDate);
                // decSkdWmd := GenerateItemAmtLine(Item,'SKD-WH-MFG',StartDate,EndDate);
                // decHskWmd := GenerateItemAmtLine(Item,'HSK-WH-MFG',StartDate,EndDate);

                decDraWmd := (GetWMD(Item."No.", StartDate, EndDate, 'DRA-WH-MFG') //Premium
                            + GetWMD(GetOtherItem(Item."No.", 'C'), StartDate, EndDate, 'DRA-WH-MFG')  // Commercial
                              + GetWMD(GetOtherItem(Item."No.", 'E'), StartDate, EndDate, 'DRA-WH-MFG')) / 6;  //Econom

                decSkdWmd := (GetWMD(Item."No.", StartDate, EndDate, 'SKD-WH-MFG') //Premium
                              + GetWMD(GetOtherItem(Item."No.", 'C'), StartDate, EndDate, 'SKD-WH-MFG')  // Commercial
                                + GetWMD(GetOtherItem(Item."No.", 'E'), StartDate, EndDate, 'SKD-WH-MFG')) / 6;  //Econom

                decHskWmd := (GetWMD(Item."No.", StartDate, EndDate, 'HSK-WH-MFG') //Premium
                              + GetWMD(GetOtherItem(Item."No.", 'C'), StartDate, EndDate, 'HSK-WH-MFG')  // Commercial
                                + GetWMD(GetOtherItem(Item."No.", 'E'), StartDate, EndDate, 'HSK-WH-MFG')) / 6;  //Econom
                                                                                                                 //WMD Calculation<<

                //Stock Calculation>>
                rItem.RESET;
                rItem.SETRANGE("No.", Item."No.");
                rItem.SETRANGE("Location Filter", 'DRA-WH-MFG');
                rItem.SETRANGE("Date Filter", 0D, AsonDate);
                IF rItem.FINDFIRST THEN BEGIN
                    rItem.CALCFIELDS(Inventory);
                    decDraStock := rItem.Inventory
                END;

                rItem.RESET;
                rItem.SETRANGE("No.", Item."No.");
                rItem.SETRANGE("Location Filter", 'SKD-WH-MFG');
                rItem.SETRANGE("Date Filter", 0D, AsonDate);
                IF rItem.FINDFIRST THEN BEGIN
                    rItem.CALCFIELDS(Inventory);
                    decSkdStock := rItem.Inventory
                END;

                rItem.RESET;
                rItem.SETRANGE("No.", Item."No.");
                rItem.SETRANGE("Location Filter", 'HSK-WH-MFG');
                rItem.SETRANGE("Date Filter", 0D, AsonDate);
                IF rItem.FINDFIRST THEN BEGIN
                    rItem.CALCFIELDS(Inventory);
                    decHskStock := rItem.Inventory
                END;
                //Stock Calculation<<

                //Pending Sales Order>>
                CLEAR(SalesOrdersDetails);
                // SalesOrdersDetails.SETRANGE(SalesOrdersDetails.OrderDateFilter,StartDate,EndDate);
                SalesOrdersDetails.SETRANGE(SalesOrdersDetails.itemNoFilter, Item."No.");
                //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter,'<>%1',SalesOrdersDetails.StatusFilter::Released);
                SalesOrdersDetails.SETRANGE(SalesOrdersDetails.Location_Code_filter, 'DRA-WH-MFG');
                SalesOrdersDetails.OPEN;
                WHILE SalesOrdersDetails.READ DO BEGIN
                    IF (SalesOrdersDetails.Commitment = 'Order Confirmation (CKA)') AND (SalesOrdersDetails.Status = SalesOrdersDetails.Status::Open) THEN BEGIN
                    END ELSE
                        decPendOrdDra += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                END;

                CLEAR(SalesOrdersDetails);
                // SalesOrdersDetails.SETRANGE(SalesOrdersDetails.OrderDateFilter,StartDate,EndDate);
                SalesOrdersDetails.SETRANGE(SalesOrdersDetails.itemNoFilter, Item."No.");
                //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter,'<>%1',SalesOrdersDetails.StatusFilter::Released);
                SalesOrdersDetails.SETRANGE(SalesOrdersDetails.Location_Code_filter, 'HSK-WH-MFG');
                SalesOrdersDetails.OPEN;
                WHILE SalesOrdersDetails.READ DO BEGIN
                    IF (SalesOrdersDetails.Commitment = 'Order Confirmation (CKA)') AND (SalesOrdersDetails.Status = SalesOrdersDetails.Status::Open) THEN BEGIN
                    END ELSE
                        decPendOrdHsk += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                END;

                CLEAR(SalesOrdersDetails);
                // SalesOrdersDetails.SETRANGE(SalesOrdersDetails.OrderDateFilter,StartDate,EndDate);
                SalesOrdersDetails.SETRANGE(SalesOrdersDetails.itemNoFilter, Item."No.");
                //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter,'<>%1',SalesOrdersDetails.StatusFilter::Released);
                SalesOrdersDetails.SETRANGE(SalesOrdersDetails.Location_Code_filter, 'SKD-WH-MFG');
                SalesOrdersDetails.OPEN;
                WHILE SalesOrdersDetails.READ DO BEGIN
                    IF (SalesOrdersDetails.Commitment = 'Order Confirmation (CKA)') AND (SalesOrdersDetails.Status = SalesOrdersDetails.Status::Open) THEN BEGIN
                    END ELSE
                        decPendOrdSkd += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                END;
                //Pending Sales Order<<

                //GIT Calculation>>
                rTransferLine.RESET;
                rTransferLine.SETRANGE("Item No.", Item."No.");
                //rTransferLine.SETRANGE("Posting Date",StartDate,EndDate);
                rTransferLine.SETRANGE("Transfer-to Code", 'DRA-WH-MFG');
                rTransferLine.SETFILTER("Quantity Shipped", '<>%1', 0);
                rTransferLine.SETFILTER("Quantity Received", '%1', 0);
                IF rTransferLine.FINDFIRST THEN BEGIN
                    rTransferLine.CALCSUMS("Qty. Shipped (Base)");
                    decGITDra := rTransferLine."Qty. Shipped (Base)";
                END;

                rTransferLine.RESET;
                rTransferLine.SETRANGE("Item No.", Item."No.");
                //rTransferLine.SETRANGE("Posting Date",StartDate,EndDate);
                rTransferLine.SETRANGE("Transfer-to Code", 'HSK-WH-MFG');
                rTransferLine.SETFILTER("Quantity Shipped", '<>%1', 0);
                rTransferLine.SETFILTER("Quantity Received", '%1', 0);
                IF rTransferLine.FINDFIRST THEN BEGIN
                    rTransferLine.CALCSUMS("Qty. Shipped (Base)");
                    decGITHsk := rTransferLine."Qty. Shipped (Base)";
                END;

                rTransferLine.RESET;
                rTransferLine.SETRANGE("Item No.", Item."No.");
                //rTransferLine.SETRANGE("Posting Date",StartDate,EndDate);
                rTransferLine.SETRANGE("Transfer-to Code", 'SKD-WH-MFG');
                rTransferLine.SETFILTER("Quantity Shipped", '<>%1', 0);
                rTransferLine.SETFILTER("Quantity Received", '%1', 0);
                IF rTransferLine.FINDFIRST THEN BEGIN
                    rTransferLine.CALCSUMS("Qty. Shipped (Base)");
                    decGITSkd := rTransferLine."Qty. Shipped (Base)";
                END;
                //GIT Calculation<<

                //RK201021>>>>>>
                CLEAR(LMSale);
                CLEAR(LMProduction);
                CLEAR(LMSaleTotal);
                CLEAR(LMProductionTotal);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.", "Posting Date", "Entry Type");
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', LMStartDate, LMEndDate);
                IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale THEN BEGIN
                            LMSale += ABS(ItemLedgerEntry."Qty in Sq.Mt.");
                            //MESSAGE('%1',LMSale);
                        END;
                        IF ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Output THEN BEGIN
                            LMProduction += ItemLedgerEntry."Qty in Sq.Mt.";
                        END;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                END;

                LMSaleTotal += LMSale;
                LMProductionTotal += LMProduction;

                CLEAR(LastProdDate);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Posting Date");
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Output);
                IF ItemLedgerEntry.FINDLAST THEN
                    LastProdDate := ItemLedgerEntry."Posting Date";

                //RK201021<<<<<<

                /*
                IF (decDraStock = 0) AND (decDraWmd = 0) AND (decHskStock = 0) AND (decHskWmd = 0) AND (decSkdStock = 0) AND (decSkdWmd = 0) AND
                    (decPendOrdDra = 0) AND (decPendOrdHsk = 0) AND (decPendOrdSkd = 0) AND (decGITDra = 0) AND (decGITHsk = 0) AND (decGITSkd = 0) THEN
                  CurrReport.SKIP;
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As On Date"; AsonDate)
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
        /*
        IF DATE2DMY(AsonDate,2) > 4 THEN
          IntYear := DATE2DMY(AsonDate,3)
        ELSE
          IntYear := DATE2DMY(AsonDate,3)-1;
        
        StartDate := DMY2DATE(1,4,IntYear);
        EndDate := AsonDate;
        
        StartDate := CALCDATE('CM-12M+1D',AsonDate);
        EndDate :=CALCDATE('-1M+CM',AsonDate);
        */
        StartDate := CALCDATE('CM-6M+1D', AsonDate);
        EndDate := CALCDATE('-1M+CM', AsonDate);
        //MESSAGE('%1..%2',StartDate,EndDate);

        LMStartDate := CALCDATE('-1M-CM', AsonDate);
        LMEndDate := CALCDATE('+CM', LMStartDate);
        //ERROR('%1= %2',LMStartDate,LMEndDate);

    end;

    var
        AsonDate: Date;
        decDraWmd: Decimal;
        decSkdWmd: Decimal;
        decHskWmd: Decimal;
        StartDate: Date;
        EndDate: Date;
        decDraStock: Decimal;
        decSkdStock: Decimal;
        decHskStock: Decimal;
        IntYear: Integer;
        rItem: Record Item;
        decPendOrdDra: Decimal;
        decPendOrdSkd: Decimal;
        decPendOrdHsk: Decimal;
        decGITDra: Decimal;
        decGITHsk: Decimal;
        decGITSkd: Decimal;
        SalesOrdersDetails: Query "Production Planing";
        rTransferLine: Record "Transfer Line";
        LMStartDate: Date;
        LMEndDate: Date;
        LMSale: Decimal;
        LMProduction: Decimal;
        LastProdDate: Date;
        LMSaleTotal: Decimal;
        LMProductionTotal: Decimal;

    local procedure GenerateItemAmtLine(recItem: Record Item; LocationCode: Code[20]; StartDate: Date; EndDate: Date) decWMD: Decimal
    var
        ItemAmount: Record "Item Amount3";
        Amount1: Decimal;
    begin
        ItemAmount.DELETEALL;

        ItemAmount.INIT;
        ItemAmount."Additional Amount" := 0;
        ItemAmount."Item No." := recItem."No.";
        ItemAmount."Inventory Posting Group" := recItem."Size Code";
        Amount1 := GetWMD(recItem."No.", StartDate, EndDate, LocationCode) //Premium
                    + GetWMD(GetOtherItem(recItem."No.", 'C'), StartDate, EndDate, LocationCode)  // Commercial
                      + GetWMD(GetOtherItem(recItem."No.", 'E'), StartDate, EndDate, LocationCode);  //Econom
        ItemAmount."Amount 2" := (Amount1) / 11;
        IF ItemAmount."Amount 2" <> 0 THEN
            ItemAmount."Additional Amount" := ABS((ItemAmount.Amount / (ItemAmount."Amount 2")) * 30)
        ELSE
            ItemAmount."Additional Amount" := ABS((ItemAmount.Amount / (1)) * 30);

        ItemAmount."Plant Code" := recItem."Size Code Desc.";
        ItemAmount."Item Description" := recItem.Description;
        ItemAmount."Manuf. Strategy" := recItem."Manuf. Strategy";
        IF recItem.Retained = TRUE THEN
            ItemAmount.Retained := TRUE
        ELSE
            ItemAmount.Retained := FALSE;
        IF (ItemAmount.Amount + ItemAmount."Amount 2") <> 0 THEN
            ItemAmount."Location Code" := 'DRA';
        ItemAmount.INSERT;
        decWMD := (Amount1) / 11;
    end;

    procedure GetWMDtest(ItemCode: Code[20]; DateFrom: Date; DateTo: Date; LocCode: Code[20]) DespatchQty: Decimal
    var
        RecILE: Record "Item Ledger Entry";
        QWD: Decimal;
        i: Integer;
        j: Integer;
        Qty: array[20] of Decimal;
        ForcastQty: array[12] of Decimal;
        ItemForcast: Record "Item Amount 4";
    begin
        QWD := 0;
        CLEAR(Qty);
        FOR i := i + 1 TO 12 DO BEGIN
            Qty[i] := 0;
            ForcastQty[i] := 0;
        END;
        ItemForcast.RESET;
        ItemForcast.SETRANGE(ItemForcast."Item No.", ItemCode);
        ItemForcast.SETRANGE("Location Code", LocCode);
        ItemForcast.SETRANGE(Date, DateFrom, DateTo);
        IF ItemForcast.FINDFIRST THEN BEGIN
            REPEAT
                ForcastQty[CalculateMonths(ItemForcast.Date, AsonDate)] += ItemForcast.Quantity;
            UNTIL ItemForcast.NEXT = 0;
        END;
        RecILE.RESET;
        RecILE.SETCURRENTKEY("Item No.", "Location Code", "Entry Type", "Posting Date");
        RecILE.SETRANGE("Item No.", ItemCode);
        RecILE.SETFILTER("Entry Type", '%1|%2', RecILE."Entry Type"::Sale, RecILE."Entry Type"::Transfer);
        RecILE.SETRANGE("Posting Date", DateFrom, DateTo);
        RecILE.SETRANGE("Location Code", LocCode);
        RecILE.SETFILTER(Quantity, '<%1', 0);
        RecILE.SETRANGE(Positive, FALSE);
        IF RecILE.FINDFIRST THEN BEGIN
            REPEAT
                CASE CalculateMonths(RecILE."Posting Date", AsonDate) OF

                    1:
                        BEGIN
                            Qty[1] += RecILE."Qty in Sq.Mt.";
                        END;

                    2:
                        BEGIN
                            Qty[2] += RecILE."Qty in Sq.Mt.";
                        END;

                    3:
                        BEGIN
                            Qty[3] += RecILE."Qty in Sq.Mt.";
                        END;

                    4:
                        BEGIN
                            Qty[4] += RecILE."Qty in Sq.Mt.";
                        END;

                    5:
                        BEGIN
                            Qty[5] += RecILE."Qty in Sq.Mt.";
                        END;

                    6:
                        BEGIN
                            Qty[6] += RecILE."Qty in Sq.Mt.";
                        END;
                /*
                7:
                BEGIN
                Qty[7] +=RecILE."Qty in Sq.Mt.";
                END;

                8:
                BEGIN
                Qty[8] +=RecILE."Qty in Sq.Mt.";
                END;

                9:
                BEGIN
                Qty[9] +=RecILE."Qty in Sq.Mt.";
                END;

                10:
                BEGIN
                Qty[10] +=RecILE."Qty in Sq.Mt.";
                END;

                11:
                BEGIN
                Qty[11] +=RecILE."Qty in Sq.Mt.";
                END;
                */
                END;
            UNTIL RecILE.NEXT = 0;
        END;



        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '1' THEN BEGIN
            Qty[1] *= 1.3;
            Qty[2] *= 1.3;
            Qty[3] *= 1.3;
            Qty[4] *= 1.3;
            Qty[5] *= 1.3;
            Qty[6] *= 1.3;
            /*
            Qty[7]*=1.3;
            Qty[8]*=1.3;
            Qty[9]*=1.3;
            Qty[10]*=1.3;
            Qty[11]*=1.3;
            */
        END;

        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '2' THEN BEGIN
            Qty[1] *= 1.2;
            Qty[2] *= 1.2;
            Qty[3] *= 1.2;
            Qty[4] *= 1.2;
            Qty[5] *= 1.2;
            Qty[6] *= 1.2;
            /*
            Qty[7]*=1.2;
            Qty[8]*=1.2;
            Qty[9]*=1.2;
            Qty[10]*=1.2;
            Qty[11]*=1.2;
            */
        END;

        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '3' THEN BEGIN
            Qty[1] *= 0.5;
            Qty[2] *= 0.5;
            Qty[3] *= 0.5;
            Qty[4] *= 0.5;
            Qty[5] *= 0.5;
            Qty[6] *= 0.5;
            /*
            Qty[7]*=0.5;
            Qty[8]*=0.5;
            Qty[9]*=0.5;
            Qty[10]*=0.5;
            Qty[11]*=0.5;
            */
        END;
        FOR i := 1 TO 6 DO BEGIN
            IF Qty[i] > 0 THEN
                ForcastQty[i] := 0;
            Qty[i] := Qty[i] + ForcastQty[i];
        END;
        /*
        QWD :=((Qty[1]*3)+
               (Qty[2]*2)+
               (Qty[3]*1)+
               (Qty[4]*1)+
               (Qty[5]*1)+
               (Qty[6]*0.7)+
               (Qty[7]*0.7)+
               (Qty[8]*0.6)+
               (Qty[9]*0.4)+
               (Qty[10]*0.3)+
               (Qty[11]*0.3));
        */
        EXIT(QWD);

    end;

    procedure GetOtherItem(ItemCode: Code[20]; Type: Code[1]): Code[20]
    var
        RecItem1: Record Item;
        Abc: Code[20];
    begin
        IF Type = 'C' THEN BEGIN
            Abc := COPYSTR(ItemCode, 1, STRLEN(ItemCode) - 2) + '2' + COPYSTR(ItemCode, STRLEN(ItemCode), STRLEN(ItemCode));
        END;
        IF Type = 'E' THEN BEGIN
            Abc := COPYSTR(ItemCode, 1, STRLEN(ItemCode) - 2) + '3' + COPYSTR(ItemCode, STRLEN(ItemCode), STRLEN(ItemCode));
        END;

        EXIT(Abc);
    end;

    procedure CalculateMonths(dtDate1: Date; DtDate2: Date): Integer
    var
        Int: Integer;
    begin
        IF dtDate1 > DtDate2 THEN
            ERROR('Date is not Correct');

        IF DATE2DMY(DtDate2, 3) <> DATE2DMY(dtDate1, 3) THEN BEGIN
            EXIT((DATE2DMY(DtDate2, 2) + 12) - DATE2DMY(dtDate1, 2));
        END ELSE BEGIN
            EXIT(DATE2DMY(DtDate2, 2) - DATE2DMY(dtDate1, 2));
        END;
    end;

    procedure GetWMD(ItemCode: Code[20]; DateFrom: Date; DateTo: Date; LocationCode: Code[20]) DespatchQty: Decimal
    var
        RecILE: Record "Item Ledger Entry";
        QWD: Decimal;
        i: Integer;
        j: Integer;
        Qty: array[20] of Decimal;
        ForcastQty: array[12] of Decimal;
        ItemForcast: Record "Item Amount 4";
    begin
        QWD := 0;
        CLEAR(Qty);
        FOR i := i + 1 TO 6 DO BEGIN
            Qty[i] := 0;
            ForcastQty[i] := 0;
        END;
        ItemForcast.RESET;
        ItemForcast.SETRANGE(ItemForcast."Item No.", ItemCode);
        ItemForcast.SETRANGE("Location Code", LocationCode);
        ItemForcast.SETRANGE(Date, DateFrom, DateTo);
        IF ItemForcast.FINDFIRST THEN BEGIN
            REPEAT
                ForcastQty[CalculateMonths(ItemForcast.Date, AsonDate)] += ItemForcast.Quantity;
            UNTIL ItemForcast.NEXT = 0;
        END;
        RecILE.RESET;
        RecILE.SETCURRENTKEY("Item No.", "Location Code", "Entry Type", "Posting Date");
        RecILE.SETRANGE("Item No.", ItemCode);
        ///RecILE.SETFILTER("Entry Type",'%1|%2',RecILE."Entry Type"::Sale,RecILE."Entry Type"::Transfer);
        RecILE.SETFILTER("Entry Type", '%1', RecILE."Entry Type"::Sale);
        RecILE.SETRANGE("Posting Date", DateFrom, DateTo);
        RecILE.SETRANGE("Location Code", LocationCode);
        RecILE.SETFILTER(Quantity, '<%1', 0);
        RecILE.SETRANGE(Positive, FALSE);
        IF RecILE.FINDFIRST THEN BEGIN
            REPEAT
                CASE CalculateMonths(RecILE."Posting Date", AsonDate) OF

                    1:
                        BEGIN
                            Qty[1] += RecILE."Qty in Sq.Mt.";
                        END;

                    2:
                        BEGIN
                            Qty[2] += RecILE."Qty in Sq.Mt.";
                        END;

                    3:
                        BEGIN
                            Qty[3] += RecILE."Qty in Sq.Mt.";
                        END;

                    4:
                        BEGIN
                            Qty[4] += RecILE."Qty in Sq.Mt.";
                        END;

                    5:
                        BEGIN
                            Qty[5] += RecILE."Qty in Sq.Mt.";
                        END;

                    6:
                        BEGIN
                            Qty[6] += RecILE."Qty in Sq.Mt.";
                        END;
                /*
                7:
                BEGIN
                Qty[7] +=RecILE."Qty in Sq.Mt.";
                END;

                8:
                BEGIN
                Qty[8] +=RecILE."Qty in Sq.Mt.";
                END;

                9:
                BEGIN
                Qty[9] +=RecILE."Qty in Sq.Mt.";
                END;

                10:
                BEGIN
                Qty[10] +=RecILE."Qty in Sq.Mt.";
                END;

                11:
                BEGIN
                Qty[11] +=RecILE."Qty in Sq.Mt.";
                END;
                */
                END;
            UNTIL RecILE.NEXT = 0;
        END;



        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '1' THEN BEGIN
            Qty[1] *= 1.3;
            Qty[2] *= 1.3;
            Qty[3] *= 1.3;
            Qty[4] *= 1.3;
            Qty[5] *= 1.3;
            Qty[6] *= 1.3;
            //Qty[7]*=1.3;
            //Qty[8]*=1.3;
            //Qty[9]*=1.3;
            //Qty[10]*=1.3;
            //Qty[11]*=1.3;
        END;

        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '2' THEN BEGIN
            Qty[1] *= 1.2;
            Qty[2] *= 1.2;
            Qty[3] *= 1.2;
            Qty[4] *= 1.2;
            Qty[5] *= 1.2;
            Qty[6] *= 1.2;
            //Qty[7]*=1.2;
            //Qty[8]*=1.2;
            //Qty[9]*=1.2;
            //Qty[10]*=1.2;
            //Qty[11]*=1.2;
        END;

        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '3' THEN BEGIN
            Qty[1] *= 0.5;
            Qty[2] *= 0.5;
            Qty[3] *= 0.5;
            Qty[4] *= 0.5;
            Qty[5] *= 0.5;
            Qty[6] *= 0.5;
            //Qty[7]*=0.5;
            //Qty[8]*=0.5;
            //Qty[9]*=0.5;
            //Qty[10]*=0.5;
            //Qty[11]*=0.5;
        END;
        FOR i := 1 TO 6 DO BEGIN
            IF Qty[i] > 0 THEN
                ForcastQty[i] := 0;
            Qty[i] := Qty[i] + ForcastQty[i];
        END;
        /*Old code Blocked on 06122019 per mail
        QWD :=((Qty[1]*3)+
               (Qty[2]*2)+
               (Qty[3]*1)+
               (Qty[4]*1)+
               (Qty[5]*1)+
               (Qty[6]*0.7));
               //(Qty[7]*0.7)+
               //(Qty[8]*0.6)+
               //(Qty[9]*0.4)+
               //(Qty[10]*0.3)+
               //(Qty[11]*0.3));
        */
        QWD := ((Qty[1] * 2) +
               (Qty[2] * 1.5) +
               (Qty[3] * 1) +
               (Qty[4] * 0.75) +
               (Qty[5] * 0.5) +
               (Qty[6] * 0.25));

        EXIT(QWD);

    end;
}

