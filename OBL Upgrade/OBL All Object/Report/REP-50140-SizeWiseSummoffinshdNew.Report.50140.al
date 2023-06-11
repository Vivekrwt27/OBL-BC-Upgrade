report 50140 "Size-Wise Summ. of finshd New"
{
    // 1. TRI NP 100510-Grouping done by Production Plant Code
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SizeWiseSummoffinshdNew.50140.rdl';
    Permissions = TableData "Item Ledger Entry" = rm;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("Default Prod. Plant Code", "Size Code", "Packing Code");
            RequestFilterFields = "No.";
            column(Summary; Summary)
            {
            }
            column(ItemPackCode; Item."Packing Code")
            {
            }
            column(ItemSizeCode; Item."Size Code")
            {
            }
            column(ItemPlantCode; Item."Plant Code")
            {
            }
            column(CurrReport_PageNo; CurrReport.PAGENO)
            {
            }
            column(CompName1; CompName1)
            {
            }
            column(CompName2; CompName2)
            {
            }
            column(HeadingText; HeadingText)
            {
            }
            column(FilterString1; FilterString1)
            {
            }
            column(ProdPlantCode; Item."Default Prod. Plant Code")
            {
            }
            column(location; "Item Ledger Entry"."Location Code")
            {
            }
            column(Plant; Plant)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(ProductionPlantCode; Plant)
            {
            }
            column(SizeName; Item."Size Code Desc.")
            {
            }
            column(PackingName; PackingName)
            {
            }
            column(OpQtyCrtn; OpQtyCrtn)
            {
            }
            column(OpQtySqm; OpQtySqm)
            {
            }
            column(OpQtymt; OpQtymt)
            {
            }
            column(OutputQtyCR; OutputQtyCR)
            {
            }
            column(OutputQtySQ; OutputQtySQ)
            {
            }
            column(RecptQtymt; RecptQtymt)
            {
            }
            column(TransferIssueCR; TransferIssueCR)
            {
            }
            column(SaleQtyCR; SaleQtyCR)
            {
            }
            column(DespatchQtyCrtn; DespatchQtyCrtn)
            {
            }
            column(DespatchQtySqm; DespatchQtySqm)
            {
            }
            column(DespatchQtyMt; DespatchQtyMt)
            {
            }
            column(ClStockCrtn; ClStockCrtn)
            {
            }
            column(ClStockSqm; ClStockSqm)
            {
            }
            column(ClStockmt; ClStockmt)
            {
            }
            column(PlantName; PlantName)
            {
            }
            column(SubTotalOpningCR; SubTotalOpningCR)
            {
            }
            column(SubTotalOpningSQ; SubTotalOpningSQ)
            {
            }
            column(SubTotalOpQtymt; SubTotalOpQtymt)
            {
            }
            column(SubTotalOPQty; SubTotalOPQty)
            {
            }
            column(SubTotalSQMtrQTY; SubTotalSQMtrQTY)
            {
            }
            column(SubTotalRecptQtymt; SubTotalRecptQtymt)
            {
            }
            column(SubTotalDespatchQtyMt; SubTotalDespatchQtyMt)
            {
            }
            column(SubTotalDispatchSQ; SubTotalDispatchSQ)
            {
            }
            column(SubTotalDispatchCR; SubTotalDispatchCR)
            {
            }
            column(SubTotalCLCR; SubTotalCLCR)
            {
            }
            column(SubTotalCLSQ; SubTotalCLSQ)
            {
            }
            column(SubTotalClStockmt; SubTotalClStockmt)
            {
            }
            column(FinalOpeningCRQty; FinalOpeningCRQty)
            {
            }
            column(FinalOpeningSQQty; FinalOpeningSQQty)
            {
            }
            column(FinalTotalOpQtymt; FinalTotalOpQtymt)
            {
            }
            column(FinalOPQty; FinalOPQty)
            {
            }
            column(FinalSQMtrQty; FinalSQMtrQty)
            {
            }
            column(FinalTotalRecptQtymt; FinalTotalRecptQtymt)
            {
            }
            column(FinalTotalDispatchCR; FinalTotalDispatchCR)
            {
            }
            column(FinalTotalDispatchSQ; FinalTotalDispatchSQ)
            {
            }
            column(FinalTotalDespatchQtyMt; FinalTotalDespatchQtyMt)
            {
            }
            column(FinalTotalCLCR; FinalTotalCLCR)
            {
            }
            column(FinalTotalCLSQ; FinalTotalCLSQ)
            {
            }
            column(FinalTotalClStockmt; FinalTotalClStockmt)
            {
            }
            column(AdjQty; AdjQty)
            {
            }
            column(AdjQtyCart; AdjQtyCart)
            {
            }
            column(AdjQtyGW; AdjQtyGW)
            {
            }
            column(AdjQtyCartP; AdjQtyCartP)
            {
            }
            column(AdjQtyP; AdjQtyP)
            {
            }
            column(AdjQtyGWP; AdjQtyGWP)
            {
            }
            column(AdjQtyCartC; AdjQtyCartC)
            {
            }
            column(AdjQtyC; AdjQtyC)
            {
            }
            column(AdjQtyGWC; AdjQtyGWC)
            {
            }

            trigger OnAfterGetRecord()
            var
                ItemRec: Record Item;
            begin
                Int += 1;
                //IF Int = 500 THEN
                //CurrReport.BREAK;


                i := COUNT;


                j += 1;
                //Win.UPDATE(2,ROUND(j/i*10000,1));


                IF "Plant Code" <> '' THEN BEGIN
                    DimensionValue.RESET;
                    DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                    DimensionValue.SETFILTER(DimensionValue.Code, "Plant Code");
                    IF DimensionValue.FIND('-') THEN
                        PlantName := DimensionValue.Name
                END ELSE
                    PlantName := '';




                //IF GlobalPackingCode <> Item."Packing Code" THEN BEGIN
                OutputQuantityCR := 0;
                OutputQuantitySQ := 0;
                OpQtyCrtn := 0;
                OpQtySqm := 0;
                OpQtymt := 0;
                ConsumptionQty := 0;
                ConsumptionQtySQMeter := 0;
                OutputQty := 0;
                QTYinSQMt := 0;
                SizeName := '';
                DespatchQtyCrtn := 0;
                DespatchQtySqm := 0;
                DespatchQtyMt := 0;
                ClStockSqm := 0;
                ClStockCrtn := 0;
                ClStockmt := 0;
                RecptQtymt := 0;
                PurchaseQtySQ := 0;
                PurchaseQtyCR := 0;
                TransferQtySQ := 0;
                TransferQtyCR := 0;
                OutputQtyCR := 0;
                OutputQtySQ := 0;
                OutputGW := 0;
                ConsumptionGW := 0;
                OPGW := 0;
                PurchaseGW := 0;
                TransferGW := 0;
                SaleQtySQ := 0;
                SaleQtyCR := 0;
                TransferIssueSQ := 0;
                TransferIssueCR := 0;
                IssueSQ := 0;
                IssueCR := 0;
                SaleIssueGW := 0;
                TransferIssueGW := 0;
                IssueGW := 0;
                AdjQty := 0;
                AdjQtyCart := 0;
                AdjQtyGW := 0;
                AdjQtyP := 0;
                AdjQtyCartP := 0;
                AdjQtyGWP := 0;
                AdjQtyC := 0;
                AdjQtyCartC := 0;
                AdjQtyGWC := 0;
                //END;
                InventorySetup.GET;
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Size Code", "Size Code") THEN
                    SizeName := DimensionValue.Name;

                PackingName := '';
                DimensionValue.RESET;
                IF DimensionValue.GET(InventorySetup."Packing Code", "Packing Code") THEN
                    PackingName := DimensionValue.Name;

                //Calculaten Opening Balance START
                ILE.RESET;
                ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                ILE.SETRANGE(ILE."Size Code", Item."Size Code");
                ILE.SETRANGE(ILE."Packing Code", Item."Packing Code");
                ILE.SETRANGE(ILE."Posting Date", 0D, FromDate - 1);

                //ILE.SETFILTER("Entry Type", '<>%1', ILE."Entry Type"::"Positive Adjmt."); //MSVRN
                IF Plant <> '' THEN
                    ILE.SETFILTER(ILE."Plant Code", Plant);
                IF Location1 <> '' THEN
                    ILE.SETFILTER(ILE."Location Code", Location1);
                ILE.CALCSUMS("Qty In Carton");
                OpQtyCrtn := ILE."Qty In Carton";
                ILE.CALCSUMS(Quantity);
                OpQtySqm := ILE.Quantity;
                OpQtymt := ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                //UNTIL ILE.NEXT = 0;

                SubTotalOpningCR := OpQtyCrtn;
                SubTotalOpningSQ := OpQtySqm;
                //Calculaten Opening Balance STOP

                //Calculate Receipt Stock START
                IF tgPlant THEN BEGIN
                    IF COPYSTR(Item."No.", (STRLEN(Item."No.")), 1) = 'M' THEN BEGIN
                        ILE.RESET;
                        //    ILE.SETCURRENTKEY("Production Plant Code","Size Code","Packing Code","Posting Date");
                        ILE.SETCURRENTKEY("Production Plant Code", "Posting Date", "Item No.");
                        ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                        ILE.SETRANGE(ILE."Size Code", Item."Size Code");
                        ILE.SETRANGE(ILE."Packing Code", Item."Packing Code");
                        ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                        ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Output);

                        IF Plant <> '' THEN
                            ILE.SETFILTER(ILE."Plant Code", Plant);
                        IF Location1 <> '' THEN
                            ILE.SETFILTER(ILE."Location Code", Location1);
                        //MSKS
                        ILE.CALCSUMS("Qty In Carton");
                        OutputQuantityCR += ILE."Qty In Carton";
                        ILE.CALCSUMS(Quantity);
                        OutputQuantitySQ += ILE.Quantity;
                        OutputGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                    END; //MSKS
                    IF COPYSTR(Item."No.", (STRLEN(Item."No.")), 1) = 'M' THEN BEGIN
                        ILE.RESET;
                        //    ILE.SETCURRENTKEY("Production Plant Code","Size Code","Packing Code","Posting Date");
                        ILE.SETCURRENTKEY("Production Plant Code", "Posting Date", "Item No.");
                        ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                        ILE.SETRANGE(ILE."Size Code", "Size Code");
                        ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                        ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                        ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Consumption);
                        //ILE.SETRANGE(ILE."Re Process Production Order",TRUE);

                        IF Plant <> '' THEN
                            ILE.SETFILTER(ILE."Plant Code", Plant);
                        IF Location1 <> '' THEN
                            ILE.SETFILTER(ILE."Location Code", Location1);
                        //MSKS
                        ILE.CALCSUMS("Qty In Carton");
                        ConsumptionQty += ILE."Qty In Carton";
                        ILE.CALCSUMS(Quantity);
                        ConsumptionQtySQMeter += ILE.Quantity;
                        ConsumptionGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                    END; //MSKS

                    OutputQty := OutputQuantityCR + (ConsumptionQty);
                    QTYinSQMt := OutputQuantitySQ + (ConsumptionQtySQMeter);

                    OPGW := OutputGW + (ConsumptionGW);
                    //   OPGW := OutputGW +(ConsumptionGW);
                END;

                IF tgstore THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Purchase);
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.CALCSUMS("Qty In Carton");
                    PurchaseQtyCR += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    PurchaseQtySQ += ILE.Quantity;
                    PurchaseGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."External Transfer", FALSE);
                    ILE.SETFILTER(ILE.Quantity, '>%1', 0);
                    ILE.CALCSUMS("Qty In Carton");
                    TransferQtyCR += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    TransferQtySQ += ILE.Quantity;
                    TransferGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                END;


                //MSVRN 020518 >>
                IF tgWarehouse THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    ILE.SETRANGE("Document Type", ILE."Document Type"::"Transfer Receipt"); //MSVRN 160518>><<
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    //ILE.SETRANGE(ILE."External Transfer",FALSE); //MSVRN 020518 /--
                    //    ILE.SETRANGE(ILE.ReProcess,FALSE);
                    ILE.SETFILTER(ILE.Quantity, '>%1', 0);
                    //TransferQtySQ += ILE.Quantity;
                    ILE.CALCSUMS("Qty in Sq.Mt.");
                    TransferQtySQ += ILE."Qty in Sq.Mt.";
                    ILE.CALCSUMS("Qty In Carton");
                    TransferQtyCR += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    TransferGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                END;

                OutputQtyCR := PurchaseQtyCR + OutputQty + TransferQtyCR;
                OutputQtySQ := PurchaseQtySQ + QTYinSQMt + TransferQtySQ;
                RecptQtymt := PurchaseGW + OutputGW + TransferGW;
                //Calculation of Receipt Stop
                //Calculate Dispatch Stock START
                IF tgWarehouse THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Sale);
                    ILE.SETFILTER("Document Type", '%1|%2', ILE."Document Type"::"Sales Shipment", ILE."Document Type"::"Transfer Shipment");
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    ILE.CALCSUMS("Qty In Carton");
                    SaleQtyCR += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    SaleQtySQ += ILE.Quantity;

                    //IF RecItem.GET(ILE."Item No.") THEN //MSVRN 020518/ Blocked
                    //SaleIssueGW += ROUND(RecItem."Gross Weight" * ILE.Quantity,0.001,'=')/1000;

                    SaleIssueGW += ROUND("Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                    //MSVRN 020518 >>
                    // Neg. and Pos Adj Calc >>
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::"Negative Adjmt.");
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    //ILE.SETFILTER(ILE.Quantity,'<%1',0);
                    ILE.CALCSUMS("Qty In Carton", Quantity);
                    AdjQtyCart += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    AdjQty += ILE.Quantity;

                    //IF RecItem.GET(ILE."Item No.") THEN //MSVRN 020518/ Blocked
                    //SaleIssueGW += ROUND(RecItem."Gross Weight" * ILE.Quantity,0.001,'=')/1000;

                    AdjQtyGW += ROUND("Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                    //--Positive>>
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::"Positive Adjmt.");
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    //ILE.SETFILTER(ILE.Quantity,'<%1',0);
                    ILE.CALCSUMS("Qty In Carton", Quantity);
                    AdjQtyCartP += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    AdjQtyP += ILE.Quantity;

                    //IF RecItem.GET(ILE."Item No.") THEN //MSVRN 020518/ Blocked
                    //SaleIssueGW += ROUND(RecItem."Gross Weight" * ILE.Quantity,0.001,'=')/1000;

                    AdjQtyGWP += ROUND("Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;


                    //--Positive<<
                    //Neg. and Pos Adj Calc <<

                    //MSVRN 160518 >>
                    //Sales Cr. Memo >>
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Sale);
                    ILE.SETRANGE("Document Type", ILE."Document Type"::"Sales Credit Memo");
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    //ILE.SETFILTER(ILE.Quantity,'<%1',0);
                    ILE.CALCSUMS("Qty In Carton", Quantity);
                    AdjQtyCartC += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    AdjQtyC += ILE.Quantity;

                    //IF RecItem.GET(ILE."Item No.") THEN //MSVRN 020518/ Blocked
                    //SaleIssueGW += ROUND(RecItem."Gross Weight" * ILE.Quantity,0.001,'=')/1000;

                    AdjQtyGWC += ROUND("Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                    //Sales Cr. Memo <<
                    //MSVRN 160518 <<

                    /*
                            ILE.RESET;
                            ILE.SETCURRENTKEY("Production Plant Code","Size Code","Packing Code","Posting Date");
                            ILE.SETRANGE(ILE."Production Plant Code",Item."Default Prod. Plant Code");
                            ILE.SETRANGE(ILE."Size Code","Size Code");
                            ILE.SETRANGE(ILE."Packing Code","Packing Code");
                            ILE.SETRANGE(ILE."Posting Date",FromDate,ToDate);
                            ILE.SETRANGE(ILE."Entry Type",ILE."Entry Type"::Transfer);
                            IF Plant <> '' THEN
                              ILE.SETFILTER(ILE."Plant Code",Plant);
                            IF Location1 <> '' THEN
                              ILE.SETFILTER(ILE."Location Code",Location1);
                            ILE.SETRANGE(ILE."External Transfer",TRUE);
                            ILE.SETFILTER(ILE.Quantity,'<%1',0);
                            ILE.CALCSUMS("Qty In Carton");
                              TransferIssueCR += ILE."Qty In Carton";
                            ILE.CALCSUMS(Quantity);
                              TransferIssueSQ += ILE.Quantity;
                              TransferIssueGW += ROUND(Item."Gross Weight" * ILE.Quantity,0.001,'=')/1000;
                            */

                    //MSVRN 020518 <<

                    DespatchQtyCrtn := ABS(SaleQtyCR) + ABS(TransferIssueCR);
                    //DespatchQtyCrtn := SaleQtyCR + TransferIssueCR;
                    DespatchQtySqm := ABS(SaleQtySQ) + ABS(TransferIssueSQ);
                    DespatchQtyMt := ABS(SaleIssueGW) + ABS(TransferIssueGW);
                END;

                IF tgstore THEN BEGIN
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::"Negative Adjmt.");
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> '' THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."Direct Consumption Entries", TRUE);
                    ILE.CALCSUMS("Qty In Carton");
                    IssueCR += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    IssueSQ += ILE.Quantity;
                    IF RecItem.GET(ILE."Item No.") THEN
                        IssueGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                    ILE.RESET;
                    ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                    ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                    ILE.SETRANGE(ILE."Size Code", "Size Code");
                    ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                    ILE.SETRANGE(ILE."Posting Date", FromDate, ToDate);
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF Plant <> '' THEN
                        ILE.SETFILTER(ILE."Plant Code", Plant);
                    IF Location1 <> ''
                    THEN
                        ILE.SETFILTER(ILE."Location Code", Location1);
                    ILE.SETRANGE(ILE."External Transfer", FALSE);
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    ILE.CALCSUMS("Qty In Carton");
                    TransferIssueCR += ILE."Qty In Carton";
                    ILE.CALCSUMS(Quantity);
                    TransferIssueSQ += ILE.Quantity;
                    TransferIssueGW += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                    DespatchQtyCrtn := ABS(IssueCR) + ABS(TransferIssueCR);
                    DespatchQtySqm := ABS(IssueSQ) + ABS(TransferIssueSQ);
                    DespatchQtyMt := ABS(IssueGW) + ABS(TransferIssueGW);
                END;

                //Calculation of Issue Stop

                //Calculation of Closing Stock Start
                ILE.RESET;
                ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                ILE.SETRANGE(ILE."Production Plant Code", Item."Default Prod. Plant Code");
                ILE.SETRANGE(ILE."Size Code", "Size Code");
                ILE.SETRANGE(ILE."Packing Code", "Packing Code");
                ILE.SETRANGE(ILE."Posting Date", 0D, ToDate);
                //ILE.SETFILTER("Entry Type", '<>%1', ILE."Entry Type"::"Positive Adjmt."); //MSVRN
                IF Plant <> '' THEN
                    ILE.SETFILTER(ILE."Plant Code", Plant);
                IF Location1 <> '' THEN
                    ILE.SETFILTER(ILE."Location Code", Location1);
                ILE.CALCSUMS("Qty In Carton");
                ClStockCrtn += ILE."Qty In Carton";
                ILE.CALCSUMS(Quantity);
                ClStockSqm += ILE.Quantity;
                ClStockmt += ROUND(Item."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;

                SubTotalOPQty := OutputQtyCR;
                SubTotalSQMtrQTY := OutputQtySQ;
                SubTotalRecptQtymt := RecptQtymt;
                SubTotalOpQtymt := OpQtymt;
                SubTotalDispatchCR := ABS(DespatchQtyCrtn);
                SubTotalDespatchQtyMt := ABS(DespatchQtyMt);
                SubTotalDispatchSQ := ABS(DespatchQtySqm);
                SubTotalClStockmt := ClStockmt;
                SubTotalCLCR := ClStockCrtn;
                SubTotalCLSQ := ClStockSqm;

                ItemRec.RESET;
                ItemRec.COPY(Item);
                IF ItemRec.NEXT <> 0 THEN BEGIN
                    IF (ItemRec."Size Code" = "Size Code") AND (ItemRec."Packing Code" = "Packing Code") AND (ItemRec."Default Prod. Plant Code" = "Default Prod. Plant Code") THEN BEGIN
                        OutputQuantityCR := 0;
                        OutputQuantitySQ := 0;
                        OpQtyCrtn := 0;
                        OpQtySqm := 0;
                        OpQtymt := 0;
                        ConsumptionQty := 0;
                        ConsumptionQtySQMeter := 0;
                        OutputQty := 0;
                        QTYinSQMt := 0;
                        SizeName := '';
                        DespatchQtyCrtn := 0;
                        DespatchQtySqm := 0;
                        DespatchQtyMt := 0;
                        ClStockSqm := 0;
                        ClStockCrtn := 0;
                        ClStockmt := 0;
                        RecptQtymt := 0;
                        PurchaseQtySQ := 0;
                        PurchaseQtyCR := 0;
                        TransferQtySQ := 0;
                        TransferQtyCR := 0;
                        OutputQtyCR := 0;
                        OutputQtySQ := 0;
                        OutputGW := 0;
                        ConsumptionGW := 0;
                        OPGW := 0;
                        PurchaseGW := 0;
                        TransferGW := 0;
                        SaleQtySQ := 0;
                        SaleQtyCR := 0;
                        TransferIssueSQ := 0;
                        TransferIssueCR := 0;
                        IssueSQ := 0;
                        IssueCR := 0;
                        SaleIssueGW := 0;
                        TransferIssueGW := 0;
                        IssueGW := 0;
                        AdjQty := 0;
                        AdjQtyCart := 0;
                        AdjQtyGW := 0;
                        AdjQtyP := 0;
                        AdjQtyCartP := 0;
                        AdjQtyGWP := 0;
                        AdjQtyC := 0;
                        AdjQtyCartC := 0;
                        AdjQtyGWC := 0;
                    END;
                END ELSE BEGIN
                    OutputQuantityCR := 0;
                    OutputQuantitySQ := 0;
                    OpQtyCrtn := 0;
                    OpQtySqm := 0;
                    OpQtymt := 0;
                    ConsumptionQty := 0;
                    ConsumptionQtySQMeter := 0;
                    OutputQty := 0;
                    QTYinSQMt := 0;
                    SizeName := '';
                    DespatchQtyCrtn := 0;
                    DespatchQtySqm := 0;
                    DespatchQtyMt := 0;
                    ClStockSqm := 0;
                    ClStockCrtn := 0;
                    ClStockmt := 0;
                    RecptQtymt := 0;
                    PurchaseQtySQ := 0;
                    PurchaseQtyCR := 0;
                    TransferQtySQ := 0;
                    TransferQtyCR := 0;
                    OutputQtyCR := 0;
                    OutputQtySQ := 0;
                    OutputGW := 0;
                    ConsumptionGW := 0;
                    OPGW := 0;
                    PurchaseGW := 0;
                    TransferGW := 0;
                    SaleQtySQ := 0;
                    SaleQtyCR := 0;
                    TransferIssueSQ := 0;
                    TransferIssueCR := 0;
                    IssueSQ := 0;
                    IssueCR := 0;
                    SaleIssueGW := 0;
                    TransferIssueGW := 0;
                    IssueGW := 0;
                    AdjQty := 0;
                    AdjQtyCart := 0;
                    AdjQtyGW := 0;
                    AdjQtyP := 0;
                    AdjQtyCartP := 0;
                    AdjQtyGWP := 0;
                    AdjQtyC := 0;
                    AdjQtyCartC := 0;
                    AdjQtyGWC := 0;
                END;

            end;

            trigger OnPostDataItem()
            begin
                //Win.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                Item.SETFILTER("Plant Code", Plant);
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
                    field("Location Filter"; Location1)
                    {
                        Caption = 'Location Filter';
                        Visible = true;
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            LocList: Page "Location List";
                            LocRec: Record Location;
                        begin
                            CLEAR(LocRec);
                            IF PAGE.RUNMODAL(PAGE::"Location List", LocRec) = ACTION::LookupOK THEN BEGIN
                                IF Location1 <> '' THEN
                                    Location1 := Location1 + '|' + LocRec.Code
                                ELSE
                                    Location1 := LocRec.Code;
                            END;
                        end;
                    }
                    field("Plant Code"; Plant)
                    {
                        Caption = 'Plant Code';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            InventorySetup: Record "Inventory Setup";
                        begin
                            InventorySetup.GET;
                            DimensionValue.RESET;
                            DimensionValue.SETFILTER(DimensionValue."Dimension Code", InventorySetup."Plant Code");
                            IF PAGE.RUNMODAL(560, DimensionValue) = ACTION::LookupOK THEN
                                Plant := DimensionValue.Code;
                        end;
                    }
                    field("From Date"; FromDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDate)
                    {
                        Caption = 'To Date';
                        ApplicationArea = All;
                    }
                    field(Summary; Summary)
                    {
                        Caption = 'Summary';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(tgPlant; tgPlant)
                    {
                        Caption = 'Plant';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF tgPlant = TRUE THEN
                                tgWarehouse := FALSE;
                        end;
                    }
                    field(tgWarehouse; tgWarehouse)
                    {
                        Caption = 'WareHouse';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF tgWarehouse = TRUE THEN
                                tgPlant := FALSE;
                        end;
                    }
                    field(tgstore; tgstore)
                    {
                        Caption = 'Store';
                        Visible = false;
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
        /*Location1 := 'SKD-MF 3';
        Plant := 'M';
        FromDate := 311016D;
        ToDate := 311016D;
        tgPlant := TRUE;
            */

    end;

    trigger OnPostReport()
    begin
        /*
    IF ExportToExcel THEN BEGIN
       ExcelBuf.CreateBook;
       ExcelBuf.CreateSheet('Size-Wise Summ. of finishd gd','',COMPANYNAME,USERID);
       ExcelBuf.GiveUserControl;
    END;
    */
        //RepAuditMgt.CreateAudit(50140)

    end;

    trigger OnPreReport()
    var
        ItemLedEntry: Record "Item Ledger Entry";
        ItemRec: Record Item;
    begin

        IF (FromDate = 0D) OR (ToDate = 0D) THEN
            ERROR(Text001);

        IF (NOT tgPlant) AND (NOT tgWarehouse) AND (NOT tgstore) THEN
            ERROR(tgext002);

        IF Plant = '' THEN
            ERROR(tgText004);

        FinalOpeningCRQty := 0;
        FinalOpeningSQQty := 0;
        FinalOPQty := 0;
        FinalSQMtrQty := 0;
        FinalTotalDispatchCR := 0;
        FinalTotalDispatchSQ := 0;
        FinalTotalCLCR := 0;
        FinalTotalCLSQ := 0;
        FinalTotalOpQtymt := 0;
        FinalTotalRecptQtymt := 0;
        FinalTotalDespatchQtyMt := 0;
        FinalTotalClStockmt := 0;
        //Win.OPEN(Text002);
        /*IF ExportToExcel THEN BEGIN
           ExcelBuf.DELETEALL;
           CLEAR(ExcelBuf);
           Entercell(1,1,'Size',TRUE,FALSE);
           Entercell(1,2,'Packing',TRUE,FALSE);
           Entercell(1,4,'Opening Stock',TRUE,FALSE);
           Entercell(2,3,'Crtn',TRUE,FALSE);
           Entercell(2,4,'Sqm.',TRUE,FALSE);
           Entercell(2,5,'Weight',TRUE,FALSE);
           Entercell(1,7,'Recieved',TRUE,FALSE);
           Entercell(2,6,'Crtn',TRUE,FALSE);
           Entercell(2,7,'Sqm.',TRUE,FALSE);
           Entercell(2,8,'Weight',TRUE,FALSE);
           Entercell(1,10,'Despatch',TRUE,FALSE);
           Entercell(2,9,'Crtn',TRUE,FALSE);
           Entercell(2,10,'Sqm.',TRUE,FALSE);
           Entercell(2,11,'Weight',TRUE,FALSE);
           Entercell(1,13,'Closing Stock',TRUE,FALSE);
           Entercell(2,12,'Crtn',TRUE,FALSE);
           Entercell(2,13,'Sqm.',TRUE,FALSE);
           Entercell(2,14,'Weight',TRUE,FALSE);
           k:=3;
        END;
         */
        CompanyInfo.GET;
        CompName1 := CompanyInfo.Name;
        CompName2 := CompanyInfo."Name 2";

        IF Summary THEN
            HeadingText := 'Size-Wise Summary of Finished Goods'
        ELSE
            HeadingText := 'Size-Wise Detail of Finished Goods';

        ItemLedEntry.RESET;
        ItemLedEntry.SETRANGE("Posting Date", FromDate, ToDate);
        ItemLedEntry.SETRANGE("Production Plant Code", '');
        IF Location1 <> '' THEN
            ItemLedEntry.SETFILTER("Location Code", Location1);
        IF ItemLedEntry.FINDFIRST THEN
            REPEAT
                IF ItemRec.GET(ItemLedEntry."Item No.") THEN
                    IF ItemRec."Default Prod. Plant Code" <> '' THEN BEGIN
                        ItemLedEntry."Production Plant Code" := ItemRec."Default Prod. Plant Code";
                        ItemLedEntry.MODIFY;
                    END;
            UNTIL
            ItemLedEntry.NEXT = 0;

    end;

    var
        Item1: Record Item;
        FromDate: Date;
        ToDate: Date;
        OpQtySqm: Decimal;
        OpQtyCrtn: Decimal;
        OpQtymt: Decimal;
        SaleQtySqm: Decimal;
        SaleQtyCrtn: Decimal;
        SaleQtyMt: Decimal;
        TrQtySqm: Decimal;
        TrQtyCrtn: Decimal;
        TrQtyMt: Decimal;
        DespatchQtySqm: Decimal;
        DespatchQtyCrtn: Decimal;
        DespatchQtyMt: Decimal;
        ClStockSqm: Decimal;
        ClStockCrtn: Decimal;
        ClStockmt: Decimal;
        Plant: Text[30];
        InventorySetup: Record "Inventory Setup";
        DimensionValue: Record "Dimension Value";
        FilterString1: Text[250];
        ItemList: Page "Item List";
        PlantName: Text[50];
        SizeName: Text[50];
        PackingName: Text[50];
        Item2: Record Item;
        Item3: Record Item;
        ILE: Record "Item Ledger Entry";
        Location: Record Location;
        LocationFilterString: Text[250];
        ILE1: Record "Item Ledger Entry";
        Contin: Boolean;
        Summary: Boolean;
        Sample: Boolean;
        ConsumptionQty: Decimal;
        ConsumptionQtySQMeter: Decimal;
        RcdQty: Decimal;
        QTYinSQMt: Decimal;
        SubTotalOPQty: Decimal;
        SubTotalSQMtrQTY: Decimal;
        FinalOPQty: Decimal;
        FinalSQMtrQty: Decimal;
        SubTotalOpningCR: Decimal;
        SubTotalOpningSQ: Decimal;
        FinalOpeningCRQty: Decimal;
        FinalOpeningSQQty: Decimal;
        RecptQtymt: Decimal;
        SubTotalDispatchCR: Decimal;
        SubTotalDispatchSQ: Decimal;
        FinalTotalDispatchCR: Decimal;
        FinalTotalDispatchSQ: Decimal;
        SubTotalCLCR: Decimal;
        SubTotalCLSQ: Decimal;
        FinalTotalCLCR: Decimal;
        FinalTotalCLSQ: Decimal;
        OutputQuantityCR: Decimal;
        OutputQuantitySQ: Decimal;
        Win: Dialog;
        HeadingText: Text[50];
        Location1: Code[1024];
        LocationRec: Record Location;
        SubTotalOpQtymt: Decimal;
        FinalTotalOpQtymt: Decimal;
        SubTotalRecptQtymt: Decimal;
        FinalTotalRecptQtymt: Decimal;
        SubTotalDespatchQtyMt: Decimal;
        FinalTotalDespatchQtyMt: Decimal;
        SubTotalClStockmt: Decimal;
        FinalTotalClStockmt: Decimal;
        tgPlant: Boolean;
        tgstore: Boolean;
        Warehouse: Boolean;
        PurchaseQtySQ: Decimal;
        PurchaseQtyCR: Decimal;
        TransferQtySQ: Decimal;
        TransferQtyCR: Decimal;
        OutputQtyCR: Decimal;
        OutputQtySQ: Decimal;
        tgWarehouse: Boolean;
        OutputGW: Decimal;
        ConsumptionGW: Decimal;
        OPGW: Decimal;
        PurchaseGW: Decimal;
        TransferGW: Decimal;
        SaleQtySQ: Decimal;
        SaleQtyCR: Decimal;
        TransferIssueSQ: Decimal;
        TransferIssueCR: Decimal;
        IssueSQ: Decimal;
        IssueCR: Decimal;
        SaleIssueGW: Decimal;
        TransferIssueGW: Decimal;
        IssueGW: Decimal;
        OutputQty: Decimal;
        i: Integer;
        j: Integer;
        RecItem: Record Item;
        ExportToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        k: Integer;
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text001: Label 'From Date and To Date is mandatory.';
        Text002: Label 'Production Plant Code #1###############\\Process @2@@@@@@@@@@@@@@@@@@@@@@@@';
        tgext002: Label 'Option Plant,Warehouse or Store should not be false at a same time on a request form.';
        tgText004: Label 'Plant code should not be blank in option form.';
        "Item Ledger Entry": Record "Item Ledger Entry";
        GlobalSizeCode: Code[30];
        GlobalPackingCode: Code[30];
        GlobalPlantCode: Code[30];
        Int: Integer;
        AdjQtyCart: Decimal;
        AdjQty: Decimal;
        AdjQtyGW: Decimal;
        AdjQtyCartP: Decimal;
        AdjQtyP: Decimal;
        AdjQtyGWP: Decimal;
        AdjQtyCartC: Decimal;
        AdjQtyC: Decimal;
        AdjQtyGWC: Decimal;

    procedure Entercell(RowNo: Integer; ColunmNo: Integer; Cellvalue: Text[150]; Bold: Boolean; Underline: Boolean)
    begin

        /*IF ExportToExcel THEN BEGIN
          ExcelBuf.INIT;
          ExcelBuf.VALIDATE("Row No.",RowNo);
          ExcelBuf.VALIDATE("Column No.",ColunmNo);
          ExcelBuf."Cell Value as Text":=Cellvalue;
          ExcelBuf.Formula:='';
          ExcelBuf.Bold:=Bold;
          ExcelBuf.Underline:=Underline;
          ExcelBuf.INSERT;
        END;
         */

    end;
}

