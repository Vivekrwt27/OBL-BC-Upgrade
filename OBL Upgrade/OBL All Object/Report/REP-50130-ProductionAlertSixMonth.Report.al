report 50130 "Production Alert Six Month"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ProductionAlertSixMonth.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Permissions = TableData 27 = rm;

    dataset
    {
        dataitem(PremiumStock; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1));
            column(CompName1; CompInfo.Name)
            {
            }
            column(CompName2; CompInfo."Name 2")
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(TIME; TIME)
            {
            }
            column(AsonDate; FORMAT(AsonDate))
            {
            }
            column(Reserve1; Reserve)
            {
            }

            trigger OnAfterGetRecord()
            begin

                StartDate := CALCDATE('CM-6M+1D', AsonDate);
                EndDate := CALCDATE('-1M+CM', AsonDate);
                //IF (COMPANYNAME='Orient Bell Limited - Bell') THEN
                //  IF AsonDate>DMY2DATE(1,4,2013) THEN BEGIN
                //    StartDate1:=StartDate;
                //    EndDate1:= DMY2DATE(31,3,2013);
                //    StartDate:=DMY2DATE(1,4,2013);
                //  END ELSE BEGIN
                //    StartDate1:=StartDate;
                //    EndDate1:= EndDate;
                //  END
                //ELSE BEGIN
                StartDate1 := StartDate;
                EndDate1 := EndDate;
                //END;


                //MESSAGE('%1-%2',StartDate,EndDate);
                //MESSAGE('%1-%2',StartDate1,EndDate1);


                ItemAmt.DELETEALL;
                ItemAmt.INIT;
                ItemAmt.RESET;
                CLEAR(Reserve);
                RecItem.RESET;

                //     RecItem.SETRANGE("No.",'027505358320313051H');
                RecItem.SETFILTER("Location Filter", LocCode);
                IF RecItem.FINDFIRST THEN BEGIN
                    REPEAT
                        RecItem.CALCFIELDS("Reserved Qty. on Inventory");
                        Reserve += RecItem."Reserved Qty. on Inventory";
                    UNTIL RecItem.NEXT = 0;
                END;
                CLEAR(RecItem);

                //RecItem.SETFILTER("No.",'%1','010104509980565101D');
                //RecItem.SETCURRENTKEY("Size Code Desc.","No.");
                RecItem.SETRANGE("Quality Code", '1');
                RecItem.SETFILTER("Item Category Code", '<>%1&<>%2', 'SAMPLE', 'T001');
                //RecItem.SETRANGE(Retained,TRUE);
                //RecItem.SETRANGE("Inactive Items",FALSE);

                IF RecItem.FINDFIRST THEN BEGIN

                    REPEAT
                        ItemAmt."Additional Amount" := 0;
                        ItemAmt."Item No." := RecItem."No.";
                        ItemAmt."Inventory Posting Group" := RecItem."Size Code";
                        ItemAmt.Amount := GetEffStk(RecItem."No.");

                        Amount1 := GetWMD(RecItem."No.", StartDate, EndDate) //Premium
                                              + GetWMD(GetOtherItem(RecItem."No.", 'C'), StartDate1, EndDate1)  // Commercial
                                              + GetWMD(GetOtherItem(RecItem."No.", 'E'), StartDate1, EndDate1);  //Econom
                                                                                                                 /*

                                                                                                                Amount2 := GetWMD1(RecItem."No.",StartDate1,EndDate1) //Premium
                                                                                                                                      +GetWMD1(GetOtherItem(RecItem."No.",'C'),StartDate1,EndDate1)  // Commercial
                                                                                                                                      +GetWMD1(GetOtherItem(RecItem."No.",'E'),StartDate1,EndDate1) ;  //Econom
                                                                                                                  */
                                                                                                                 //    ItemAmt."Amount 2":=(Amount1+Amount2)/11; Kulbhushan
                        ItemAmt."Amount 2" := (Amount1) / 6;


                        /* ItemAmt."Amount 2" := GetWMD(RecItem."No.",StartDate,EndDate) //Premium
                                               +GetWMD(GetOtherItem(RecItem."No.",'C'),StartDate,EndDate)  // Commercial
                                               +GetWMD(GetOtherItem(RecItem."No.",'E'),StartDate,EndDate) ;  //Econom
                         */
                        IF ItemAmt."Amount 2" <> 0 THEN
                            ItemAmt."Additional Amount" := ABS((ItemAmt.Amount / (ItemAmt."Amount 2")) * 30)
                        ELSE
                            ItemAmt."Additional Amount" := ABS((ItemAmt.Amount / (1)) * 30);
                        ItemAmt."Plant Code" := RecItem."Size Code Desc.";
                        ItemAmt."Item Description" := RecItem.Description;
                        ItemAmt."Manuf. Strategy" := RecItem."Manuf. Strategy";
                        IF RecItem.Retained = TRUE THEN
                            ItemAmt.Retained := TRUE
                        ELSE
                            ItemAmt.Retained := FALSE;
                        IF (ItemAmt.Amount + ItemAmt."Amount 2") <> 0 THEN
                            ItemAmt.INSERT;
                    UNTIL RecItem.NEXT = 0;
                END;
                COMMIT;
                RecItemAmt3.RESET;
                RecItemAmt3.SETRANGE(RecItemAmt3.Retained, FALSE);
                //RecItemAmt3.SETRANGE("Item No.","Item No.");
                IF RecItemAmt3.FINDFIRST THEN
                    REPEAT
                        IF (RecItemAmt3.Amount + RecItemAmt3."Amount 2") <> 0 THEN BEGIN
                            // InactCount += 1;
                            k += 1;
                            NRAmount += RecItemAmt3.Amount;
                            NRAmount2 += RecItemAmt3."Amount 2";
                        END;
                    UNTIL RecItemAmt3.NEXT = 0;


                PrintTotal := FALSE;

            end;
        }
        dataitem("Item Amount3"; 50000)
        {
            DataItemTableView = SORTING(Retained, "Plant Code", "Additional Amount")
                                ORDER(Ascending);
            column(ItemNo; "Item Amount3"."Item No.")
            {
            }
            column(Desc1; Item.Description)
            {
            }
            column(Desc2; Item."Description 2")
            {
            }
            column(ItemDes; ItemRec1.Description)
            {
            }
            column(ItemDes2; ItemRec1."Description 2")
            {
            }
            column(AddAmt; ABS("Item Amount3"."Additional Amount"))
            {
            }
            column(PlantCode; "Item Amount3"."Plant Code")
            {
            }
            column(Active; Active)
            {
            }
            column(IA3Amount; ABS("Item Amount3".Amount))
            {
            }
            column(Day2; ABS(Day2))
            {
            }
            column(IA3Amount2; (ABS("Item Amount3"."Amount 2")))
            {
            }
            column(FinalTotalAmt; ABS(FinalTotalAmt))
            {
            }
            column(day4; ABS(day4))
            {
            }
            column(FinalTotalAmt2; ABS(FinalTotalAmt2))
            {
            }
            column(NRAmount; ABS(NRAmount))
            {
            }
            column(NRAmount2; ABS(NRAmount2))
            {
            }
            column(Day3; ABS(Day3))
            {
            }
            column(j; j)
            {
            }
            column(CreatedDate; (ItemRec1."Created Date"))
            {
            }
            column(LastProdDate; (LastProdDate))
            {
            }
            column(FIRSTProdDate; (FIRSTProdDate))
            {
            }
            column(TempAct; TempAct)
            {
            }
            column(InactCount; InactCount)
            {
            }
            column(manufsta; Item."Manuf. Strategy")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF ABS("Additional Amount")=0 THEN Kulbhushan
                //CurrReport.SKIP;
                IF ItemRec1.GET("Item No.") THEN;
                //CLEAR(ShowEntry);
                IF Retained = TRUE THEN BEGIN
                    i += 1;
                    j += 1;
                    IF Item.GET("Item No.") THEN;

                    //CurrReport.SHOWOUTPUT(TRUE);
                END ELSE BEGIN
                    ShowEntry := TRUE;
                    CurrReport.SKIP;
                END;
                CLEAR(FIRSTProdDate);
                ItemLedEntry.RESET;
                ItemLedEntry.SETCURRENTKEY("Posting Date");
                ItemLedEntry.SETRANGE("Item No.", "Item Amount3"."Item No.");
                ItemLedEntry.SETFILTER("Entry Type", '%1|%2', ItemLedEntry."Entry Type"::Output, ItemLedEntry."Entry Type"::Purchase);
                IF ItemLedEntry.FINDFIRST THEN
                    FIRSTProdDate := ItemLedEntry."Posting Date";
                CLEAR(LastProdDate);
                ItemLedEntry.RESET;
                ItemLedEntry.SETCURRENTKEY("Posting Date");
                ItemLedEntry.SETRANGE("Item No.", "Item Amount3"."Item No.");
                ItemLedEntry.SETFILTER("Entry Type", '%1|%2', ItemLedEntry."Entry Type"::Output, ItemLedEntry."Entry Type"::Purchase);
                //ItemLedEntry.SETRANGE("Entry Type",ItemLedEntry."Entry Type"::Output);
                IF ItemLedEntry.FINDLAST THEN
                    LastProdDate := ItemLedEntry."Posting Date";

                IF Retained = TRUE THEN BEGIN
                    i += 1;
                    j += 1;
                    Active := i;
                    i := 0;
                    TotalAmount += Amount;
                    TotalAmount2 += "Amount 2";
                    IF "Amount 2" <> 0 THEN
                        Day2 := (Amount / ("Amount 2")) * 30
                    ELSE
                        Day2 := (Amount / 1) * 30;

                    FinalTotalAmt += Amount;
                    FinalTotalAmt2 += ("Amount 2");
                END;

                IF FinalTotalAmt2 <> 0 THEN
                    day4 := ABS((FinalTotalAmt / FinalTotalAmt2) * 30)
                ELSE
                    day4 := ABS((FinalTotalAmt / 1) * 30);

                CLEAR(InactCount);
                IF PrintInActive = TRUE THEN BEGIN

                    k := 0;
                    RecItemAmt3.RESET;
                    RecItemAmt3.SETRANGE(RecItemAmt3.Retained, FALSE);
                    //RecItemAmt3.SETRANGE("Item No.","Item No.");
                    IF RecItemAmt3.FINDFIRST THEN
                        REPEAT
                            IF (RecItemAmt3.Amount + RecItemAmt3."Amount 2") <> 0 THEN BEGIN
                                InactCount += 1;
                                k += 1;
                                //  NRAmount+=RecItemAmt3.Amount;
                                //  NRAmount2+=RecItemAmt3."Amount 2";
                            END;
                        UNTIL RecItemAmt3.NEXT = 0;
                    //RecItemAmt3.

                    IF NRAmount2 <> 0 THEN BEGIN
                        Day3 := (NRAmount / NRAmount2) * 30
                    END ELSE
                        Day3 := (NRAmount / 1) * 30;
                    // 16630      CurrReport.SHOWOUTPUT := TRUE
                END;
                UpdateItem("Item Amount3"."Item No.", "Item Amount3"."Amount 2");
                //CurrReport.SKIP;
                TempAct := 1
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field("Report Date"; AsonDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Location Code"; LocCode)
                    {
                        TableRelation = Location;
                        ApplicationArea = All;
                    }
                    field("Print IN-Active"; PrintInActive)
                    {
                        Editable = false;
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
        PrintInActive := TRUE;
    end;

    trigger OnPostReport()
    begin

        ItemAmt.DELETEALL;
        //RepAuditMgt.CreateAudit(50254)
    end;

    trigger OnPreReport()
    begin
        ItemAmt.DELETEALL;
        CompInfo.GET();
        IF AsonDate = 0D THEN
            AsonDate := TODAY;
    end;

    var
        ItemAmt: Record "Item Amount3";
        RecItem: Record Item;
        LocCode: Code[20];
        AsonDate: Date;
        StartDate: Date;
        EndDate: Date;
        Qty: array[20] of Decimal;
        SizeCode: Code[20];
        SubTotalAmt: Decimal;
        SubTotalAmt2: Decimal;
        Day1: Decimal;
        IntCount: Integer;
        ItemCode11: Code[1000];
        IntCount1: Integer;
        TotalPintCount: Integer;
        SubTotalAmtFinal: Decimal;
        SubTotalAmtFinal2: Decimal;
        PrintTotal: Boolean;
        Ks: Decimal;
        i: Integer;
        j: Integer;
        TotalAmount: Decimal;
        TotalAmount2: Decimal;
        Active: Integer;
        Item2m: Code[20];
        Item3m: Code[20];
        Day2: Decimal;
        FinalTotalAmt: Decimal;
        FinalTotalAmt2: Decimal;
        k: Integer;
        RecItemAmt3: Record "Item Amount3";
        NRAmount: Decimal;
        NRAmount2: Decimal;
        Day3: Decimal;
        day4: Decimal;
        PrintInActive: Boolean;
        "----Print To Excel----": Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        StartDate1: Date;
        EndDate1: Date;
        Amount1: Decimal;
        Amount2: Decimal;
        Total1Amount: Decimal;
        Total1Amount2: Decimal;
        GTotal1Amount: Decimal;
        GTotal1Amount2: Decimal;
        Item: Record Item;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        CompInfo: Record "Company Information";
        LocationRec: Record Location;
        ShowEntry: Boolean;
        ItemRec1: Record Item;
        ItemLedEntry: Record "Item Ledger Entry";
        FIRSTProdDate: Date;
        LastProdDate: Date;
        TempAct: Integer;
        InactCount: Integer;
        Reserve: Decimal;
        ItemForcast: Record "Item Amount 4";
        ForcastQty: array[12] of Decimal;

    procedure GetEffStk(ItemCd: Code[20]) Stock: Decimal
    var
        RecItem: Record Item;
        ComStock: Decimal;
        PremStock: Decimal;
        EcoStock: Decimal;
    begin
        //Get Commercial Stock
        IF RecItem.GET(GetOtherItem(ItemCd, 'C')) THEN BEGIN
            RecItem.SETFILTER("Location Filter", LocCode);
            RecItem.CALCFIELDS(Inventory);
            ComStock := RecItem.Inventory - RecItem."Reserved Qty. on Inventory";
            // ComStock:=RecItem.Inventory
        END;


        //Premium Stock
        IF RecItem.GET(ItemCd) THEN BEGIN
            RecItem.SETFILTER("Location Filter", LocCode);
            RecItem.CALCFIELDS(Inventory);
            RecItem.CALCFIELDS("Reserved Qty. on Inventory");
            PremStock := RecItem.Inventory - RecItem."Reserved Qty. on Inventory";// Kulbhushan
                                                                                  //  PremStock:=RecItem.Inventory
        END;

        //MESSAGE('%1',RecItem.Inventory);
        /*Old Code Block on 06122019 as per mail
        IF (PremStock*0.3) < ComStock THEN  BEGIN
        Stock :=(PremStock*0.3) + PremStock ;
        END ELSE
        Stock :=(ComStock) + PremStock;
        EXIT(Stock);
        */
        EXIT(PremStock);

    end;

    procedure GetWMD(ItemCode: Code[20]; DateFrom: Date; DateTo: Date) DespatchQty: Decimal
    var
        RecILE: Record "Item Ledger Entry";
        QWD: Decimal;
        i: Integer;
        j: Integer;
    begin
        QWD := 0;
        CLEAR(Qty);
        FOR i := i + 1 TO 6 DO BEGIN
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

    procedure "---Print To Excel---"()
    begin
    end;

    procedure MakeExcelDataHeader()
    begin
        /*ExcelBuf.AddColumn('Item',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Description',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Eff. Stk (m2)',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('WMD',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('DOB',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Last Pdn',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Contribution',FALSE,'',TRUE,FALSE,TRUE,'');
        */

    end;

    procedure CreateExcelbook()
    begin
        /*ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet('Inventory Status Active','',COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
         */

    end;

    procedure GetWMD1(ItemCode: Code[20]; DateFrom: Date; DateTo: Date) DespatchQty: Decimal
    var
        ItemAmount4: Record "Item Amount 4";
        QWD: Decimal;
        i: Integer;
    begin

        QWD := 0;
        CLEAR(Qty);
        FOR i := i + 1 TO 6 DO BEGIN
            Qty[i] := 0;
        END;

        //MESSAGE('%1',AsonDate);


        ItemAmount4.RESET;
        ItemAmount4.SETRANGE("Item No.", ItemCode);
        ItemAmount4.SETFILTER(Date, '%1..%2', DateFrom, DateTo);
        ItemAmount4.SETFILTER("Location Code", LocCode);
        ItemAmount4.SETFILTER(Quantity, '<%1', 0);

        IF ItemAmount4.FINDFIRST THEN BEGIN
            REPEAT
                CASE CalculateMonths(ItemAmount4.Date, AsonDate) OF
                    1:
                        BEGIN
                            Qty[1] += ItemAmount4.Quantity;
                        END;
                    2:

                        BEGIN
                            Qty[2] += ItemAmount4.Quantity;
                        END;

                    3:
                        BEGIN
                            Qty[3] += ItemAmount4.Quantity;
                        END;

                    4:
                        BEGIN
                            Qty[4] += ItemAmount4.Quantity;
                        END;

                    5:
                        BEGIN
                            Qty[5] += ItemAmount4.Quantity;
                        END;

                    6:
                        BEGIN
                            Qty[6] += ItemAmount4.Quantity;
                        END;
                /*
                7:
                BEGIN
                Qty[7] +=ItemAmount4.Quantity;
                END;

                8:
                BEGIN
                Qty[8] +=ItemAmount4.Quantity;
                END;

                9:
                BEGIN
                Qty[9] +=ItemAmount4.Quantity;
                END;

                10:
                BEGIN
                Qty[10] +=ItemAmount4.Quantity;
                END;

                11:
                BEGIN
                Qty[11] +=ItemAmount4.Quantity;
                END;
                */
                END;
            UNTIL ItemAmount4.NEXT = 0;
        END;


        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '1' THEN BEGIN
            Qty[1] *= 1.3;
            Qty[2] *= 1.3;
            Qty[3] *= 1.3;
            Qty[4] *= 1.3;
            Qty[5] *= 1.3;
            Qty[6] *= 1.3;
            /*Qty[7]*=1.3;
            Qty[8]*=1.3;
            Qty[9]*=1.3;
            Qty[10]*=1.3;
            Qty[11]*=1.3;*/
        END;

        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '2' THEN BEGIN
            Qty[1] *= 1.2;
            Qty[2] *= 1.2;
            Qty[3] *= 1.2;
            Qty[4] *= 1.2;
            Qty[5] *= 1.2;
            Qty[6] *= 1.2;
            /*Qty[7]*=1.2;
            Qty[8]*=1.2;
            Qty[9]*=1.2;
            Qty[10]*=1.2;
            Qty[11]*=1.2;*/
        END;

        IF COPYSTR(ItemCode, STRLEN(ItemCode) - 1, 1) = '3' THEN BEGIN
            Qty[1] *= 0.5;
            Qty[2] *= 0.5;
            Qty[3] *= 0.5;
            Qty[4] *= 0.5;
            Qty[5] *= 0.5;
            Qty[6] *= 0.5;
            /*Qty[7]*=0.5;
            Qty[8]*=0.5;
            Qty[9]*=0.5;
            Qty[10]*=0.5;
            Qty[11]*=0.5;*/
        END;


        QWD := ((Qty[1] * 3) +
               (Qty[2] * 2) +
               (Qty[3] * 1) +
               (Qty[4] * 1) +
               (Qty[5] * 1) +
               (Qty[6] * 0.7));
        /*(Qty[7]*0.7)+
        (Qty[8]*0.6)+
        (Qty[9]*0.4)+
        (Qty[10]*0.3)+
        (Qty[11]*0.3));*/

        EXIT(QWD);

    end;

    procedure SetLocationFilter(LocFilter: Text)
    begin
        LocCode := LocFilter;
    end;

    local procedure UpdateItem(ItemNo: Code[20]; DecWDV: Decimal)
    var
        UpdateItem: Record 27;
    begin
        IF UpdateItem.GET(ItemNo) THEN BEGIN
            UpdateItem.WDM := DecWDV;
            UpdateItem.MODIFY;
        END;
    end;
}

