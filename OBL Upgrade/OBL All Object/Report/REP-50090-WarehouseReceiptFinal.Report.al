report 50090 "Warehouse Receipt(Final)"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\WarehouseReceiptFinal.rdl';
    Permissions = TableData "Item Ledger Entry" = rm;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; 32)
        {
            DataItemTableView = SORTING("Production Plant Code", "Posting Date", "Item No.")
                                ORDER(Ascending)
                                WHERE("Item No." = FILTER('@*M|@*D|@*H'),
                                      "Document No." = FILTER('RPO*'),
                                      "Location Code" = FILTER('<>SKD-SAMPLE'));
            RequestFilterFields = "Posting Date", "Item No.", "Location Code", "Plant Code", "Production Plant Code";
            RequestFilterHeading = 'Warehouse Receipt';
            column(CompInfoName; "Company Information".Name)
            {
            }
            column(CompInfoName2; "Company Information"."Name 2")
            {
            }
            column(CompInfoAddress; "Company Information".Address)
            {
            }
            column(CompInfoAddress2; "Company Information"."Address 2")
            {
            }
            column(CompInfoCity; "Company Information".City)
            {
            }
            column(Postcode; "Company Information"."Post Code")
            {
            }
            column(CompInfoState; "Company Information"."Importer Code No.")// 16630 replace State
            {
            }
            column(Filters; Filters)
            {
            }
            column(QtyinSqMt_ItemLedgerEntry; "Item Ledger Entry"."Qty in Sq.Mt.")
            {
            }
            column(QtyInCarton_ItemLedgerEntry; "Item Ledger Entry"."Qty In Carton")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(ItemDes; ItemDes)
            {
            }
            column(TransQuantityCR; TransQuantityCR)
            {
            }
            column(TransQuantitySQ; TransQuantitySQ)
            {
            }
            column(GrossWt; RecItem."Gross Weight")
            {
            }
            column(PDT; acttime)
            {
            }
            column(NetWt; RecItem."Net Weight")
            {
            }
            column(TotalQuantityCR; TotalQuantityCR)
            {
            }
            column(TransQtyInSQMT; TransQtyInSQMT)
            {
            }
            column(TotalTransQty; TotalTransQty)
            {
            }
            column(TotalTransQTM; TotalTransQTM)
            {
            }
            column(DocumentNo; "Item Ledger Entry"."Document No.")
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(DocNo2; DocNo2)
            {
            }
            column(OutputQuantityCR; OutputQuantityCR)
            {
            }
            column(GrwtTotal; "Item Ledger Entry"."Qty in Sq.Mt." * RecItem."Gross Weight")
            {
            }
            column(NetwtTotal; "Item Ledger Entry"."Qty in Sq.Mt." * RecItem."Net Weight")
            {
            }
            column(Manuf_Strategy; RecItem."Manuf. Strategy")
            {
            }
            column(Loca; "Item Ledger Entry"."Location Code")
            {
            }
            column(blnAdmin; blnAdmin)
            {
            }

            trigger OnAfterGetRecord()
            begin
                blnAdmin := FALSE;
                IF (UPPERCASE(USERID) = 'FA017') THEN
                    blnAdmin := TRUE;

                CurrReport.CREATETOTALS("Item Ledger Entry"."Gross Weight", "Item Ledger Entry"."Net Weight");

                OutputQuantityCR := 0;
                OutputQuantitySQ := 0;
                OutputGW := 0;
                ConQuantityCR := 0;
                ConQuantitySQ := 0;
                ConGW := 0;
                TransQuantityCR := 0;
                TransQuantitySQ := 0;
                TransGW := 0;
                //IF "Item Ledger Entry"."Location Code"<>"Item Ledger Entry"."Production Plant Code" THEN
                //CurrReport.SKIP;

                ILE.RESET;
                ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                ILE.SETRANGE(ILE."Posting Date", "Posting Date");
                ILE.SETRANGE(ILE."Item No.", "Item No.");
                ILE.SETRANGE(ILE."Location Code", "Location Code");
                ILE.SETRANGE(ILE."Plant Code", "Plant Code");
                ILE.SETRANGE("Production Plant Code", "Production Plant Code"); //MSKS
                ILE.SETRANGE("Size Code", "Size Code");//MSKS
                ILE.SETRANGE("Packing Code", "Packing Code");//MSKS
                ILE.SETFILTER("Entry Type", '%1', ILE."Entry Type"::Output);//,ILE."Entry Type"::Consumption);
                IF ILE.FIND('-') THEN
                    REPEAT

                        OutputQuantityCR += ILE."Qty In Carton";
                        OutputQuantitySQ += ILE.Quantity;

                        IF RecItem.GET(ILE."Item No.") THEN
                            OutputGW += ROUND(RecItem."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                    UNTIL ILE.NEXT = 0;

                //MSKS0702 Start
                ILE.RESET;
                ILE.SETCURRENTKEY("Production Plant Code", "Size Code", "Packing Code", "Posting Date");
                ILE.SETRANGE(ILE."Posting Date", "Posting Date");
                ILE.SETRANGE(ILE."Item No.", "Item No.");
                ILE.SETRANGE(ILE."Location Code", "Location Code");
                ILE.SETRANGE(ILE."Plant Code", "Plant Code");
                ILE.SETRANGE(ILE."Re Process Production Order", TRUE);
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Consumption);
                ILE.SETRANGE("Production Plant Code", "Production Plant Code"); //MSKS
                ILE.SETRANGE("Size Code", "Size Code");//MSKS
                ILE.SETRANGE("Packing Code", "Packing Code");//MSKS

                IF ILE.FIND('-') THEN
                    REPEAT
                        OutputQuantityCR += ILE."Qty In Carton";
                        OutputQuantitySQ += ILE.Quantity;

                        IF RecItem.GET(ILE."Item No.") THEN
                            OutputGW += ROUND(RecItem."Gross Weight" * ILE.Quantity, 0.001, '=') / 1000;
                    UNTIL ILE.NEXT = 0;

                //MSKS0702 End

                ILE2.RESET;
                ILE2.SETRANGE("Posting Date", "Posting Date");
                ILE2.SETRANGE("Item No.", "Item No.");
                ILE2.SETRANGE("Location Code", "Location Code");
                ILE2.SETRANGE("Plant Code", "Plant Code");
                ILE2.SETFILTER("Entry Type", '%1', "Entry Type"::Transfer);
                ILE2.SETRANGE("External Transfer", FALSE);
                IF ILE2.FIND('-') THEN BEGIN
                    DocNo := ILE2."Document No.";
                    REPEAT
                        TransQuantityCR += (ILE2."Qty In Carton");
                        TransQuantitySQ += ILE2.Quantity;
                        IF RecItem.GET(ILE2."Item No.") THEN
                            TransGW += ROUND(RecItem."Gross Weight" * ILE2.Quantity, 0.001, '=') / 1000;
                        ;
                        TransNetW += ROUND(RecItem."Net Weight" * ILE2.Quantity, 0.001, '=') / 1000;
                    UNTIL ILE2.NEXT = 0;
                END;


                /*IF CurrReport.SHOWOUTPUT THEN BEGIN
                
                CurrReport.SHOWOUTPUT :=
                  CurrReport.TOTALSCAUSEDBY = "Item Ledger Entry".FIELDNO("Item No.");
                END;
                */
                IF ItemNo <> "Item Ledger Entry"."Item No." THEN BEGIN
                    "ChangeItemNo." := TRUE;


                    IF RecItem.GET("Item Ledger Entry"."Item No.") THEN BEGIN
                        ItemDes := RecItem.Description + ' ' + RecItem."Description 2";
                    END;
                    //AND(TransQuantityCR>0)AND(TransQuantitySQ>0)
                    /*IF CurrReport.SHOWOUTPUT((OutputQuantityCR<>0 ) OR (OutputQuantitySQ <>0) OR (TransGW<>0) OR (ABS(TransQuantityCR)<>0))THEN BEGIN
                       TotalQuantityCR +=OutputQuantityCR;
                       TransQtyInSQMT +=OutputQuantitySQ ;
                       TotalTransQty +=TransQuantityCR;
                       TotalTransQTM +=TransQuantitySQ;
                       tOTALgROSSwT +=RecItem."Gross Weight"*"Qty in Sq.Mt.";
                      totalnetwt +=RecItem."Net Weight"*"Qty in Sq.Mt.";

                     END;

                     IF (OutputQuantityCR<=0) THEN
                     BEGIN
                      CurrReport.SHOWOUTPUT(FALSE)
                     END
                     ELSE
                       CurrReport.SHOWOUTPUT(TRUE);
                     */
                    TotalQuantityCR += OutputQuantityCR;
                    TransQtyInSQMT += OutputQuantitySQ;
                    TotalTransQty += TransQuantityCR;

                    TotalTransQTM += TransQuantitySQ;
                END
                ELSE BEGIN
                    "ChangeItemNo." := FALSE;
                END;
                ItemNo := "Item Ledger Entry"."Item No.";
                IF CurrReport.SHOWOUTPUT THEN BEGIN
                    TotalQuantityCR += "Qty In Carton";//OutputQuantityCR;
                    TransQtyInSQMT += "Qty in Sq.Mt.";//OutputQuantitySQ ;
                    TotalTransQty += TransQuantityCR;
                    TotalTransQTM += TransQuantitySQ;
                    tOTALgROSSwT += RecItem."Gross Weight" * "Qty in Sq.Mt.";
                    totalnetwt += RecItem."Net Weight" * "Qty in Sq.Mt.";
                END;


                ///
                IF TransQuantityCR = 0 THEN
                    DocNo2 := 'Pending For Transfer'
                ELSE
                    DocNo2 := DocNo;

                PendforTrans := "Item Ledger Entry"."Qty In Carton" - TotalTransQty;

                ILE2.SETFILTER("Entry Type", '%1', "Entry Type"::Transfer);
                IF ILE2.FIND('-') THEN
                    acttime := ILE2."Posting Datetime";

            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("Item No.");
                PlantCode := GETFILTER("Plant Code");

                IF PlantCode <> '' THEN
                    SETRANGE("Plant Code", PlantCode)
                ELSE
                    SETFILTER("Plant Code", 'M|H|D');

                Filters := "Item Ledger Entry".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        //RB16630 REPORT.RUNMODAL(50216, FALSE, FALSE, "Item Ledger Entry");
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        "Company Information": Record "Company Information";
        OutputQtyCR: Decimal;
        QTYinSQMt: Decimal;
        TransferQty: Decimal;
        TransQtyInSQMT: Decimal;
        TransGross: Decimal;
        TransNetW: Decimal;
        ILE: Record "Item Ledger Entry";
        OutputQuantityCR: Decimal;
        OutputQuantitySQ: Decimal;
        RecItem: Record Item;
        OutputGW: Decimal;
        ConQuantityCR: Decimal;
        ConQuantitySQ: Decimal;
        ConGW: Decimal;
        TransQuantityCR: Decimal;
        TransQuantitySQ: Decimal;
        TransGW: Decimal;
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        SubTotalTransQty: Decimal;
        FinalOPQty: Decimal;
        TotalTransQty: Decimal;
        TotalTransQTM: Decimal;
        PendforTrans: Decimal;
        TotalQuantityCR: Decimal;
        var1: Code[20];
        ItemDes: Text;
        ExcelBuf: Record "Excel Buffer" temporary;
        k: Integer;
        PrintToExcel: Boolean;
        TotalQuantitySQM: Decimal;
        tOTALgROSSwT: Decimal;
        totalnetwt: Decimal;
        ItemNo: Code[40];
        "ChangeItemNo.": Boolean;
        PlantCode: Code[10];
        Item: Record Item;
        ILEUpdate: Record "Item Ledger Entry";
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Filters: Text;
        DocNo: Code[30];
        DocNo2: Code[30];
        blnAdmin: Boolean;
        acttime: DateTime;
}

