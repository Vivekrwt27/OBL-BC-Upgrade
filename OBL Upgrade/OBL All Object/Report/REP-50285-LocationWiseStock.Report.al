report 50285 "Location Wise Stock"
{
    // 
    // "Total Stk In" :=  PurchasesInc + "Sales Return" + "Transfer Receipt" + "Positive Adj" + Output + AssOutput;
    // "Total Stk Out" := "Total Stk Out" +Sales + "Purch Return" + "Transfer Shipment" + "Negative Adj" + Consumption;
    // "Closing Stock" := "Opening Stock" + "Total Stk In" + "Total Stk Out";
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\LocationWiseStock.rdl';


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Location Code", "Item No.", "Variant Code", Open, Positive, "Posting Date");
            RequestFilterFields = "Location Code", "Item Category Code", "Item Base Unit of Measure";
            column(Sdate; Sdate)
            {
            }
            column(Edate; Edate)
            {
            }
            column(LocationFilter; "Item Ledger Entry".GETFILTER("Location Code"))
            {
            }
            column(summery; summery)
            {
            }
            column(LocationCode; "Item Ledger Entry"."Location Code")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(UOM; "Item Base Unit of Measure")
            {
            }
            column(InvPostingGrp; "Inventory Posting Group")
            {
            }
            column(ItemDes; FORMAT(ItemDesc))
            {
            }
            column(OpeningStk; ROUND("Opening Stock", 0.01))
            {
            }
            column(PurchasesInc; ROUND(ABS(PurchasesInc), 0.01))
            {
            }
            column(SalesReturn; ROUND(ABS("Sales Return"), 0.01))
            {
            }
            column(TransferReceipt; ROUND(ABS("Transfer Receipt"), 0.01))
            {
            }
            column(PositiveAd; ROUND(ABS("Positive Adj"), 0.01))
            {
            }
            column(Ouput; ROUND(ABS(Output), 0.01))
            {
            }
            column(AssOutput; ROUND(ABS(AssOutput), 0.01))
            {
            }
            column(TotalStkIn; ROUND(ABS("Total Stk In"), 0.01))
            {
            }
            column(Sales; ROUND(ABS(Sales), 0.01))
            {
            }
            column(PurchReturn; ROUND(ABS("Purch Return"), 0.01))
            {
            }
            column(TransferShip; ROUND(ABS("Transfer Shipment"), 0.01))
            {
            }
            column(NegativeAdj; ROUND(ABS("Negative Adj"), 0.01))
            {
            }
            column(Cons; ROUND(ABS(Consumption), 0.01))
            {
            }
            column(TotalStkOut; ROUND(ABS("Total Stk Out"), 0.01))
            {
            }
            column(ClosingStk; ROUND(("Closing Stock"), 0.01))
            {
            }
            column(ItemCatCOde; ("Item Category Code"))
            {
            }
            column(manuf; RecItem."Manuf. Strategy")
            {
            }
            column(Location_name; Location.Name)
            {
            }
            column(blnAdmin; blnAdmin)
            {
            }
            column(CRT; ROUND(("Closing Stock"), 0.01))
            {
            }
            column(PerQty; "Qty In Carton")
            {
            }
            column(ClosingCRT; ClosingCRT)
            {
            }

            trigger OnAfterGetRecord()
            begin

                blnAdmin := TRUE;
                IF UPPERCASE(USERID) = 'DE002' THEN
                    blnAdmin := FALSE;

                CALCFIELDS("Item Base Unit of Measure");
                CALCFIELDS("Inventory Posting Group");
                IF (PrevItemNo = "Item No.") AND (PrevLoc = "Location Code") THEN
                    CurrReport.SKIP;

                PrevItemNo := "Item No.";
                PrevLoc := "Location Code";
                "Opening Stock" := 0;
                PurchasesInc := 0;
                "Sales Return" := 0;
                "Transfer Receipt" := 0;
                "Positive Adj" := 0;
                Output := 0;
                "Total Stk In" := 0;
                Sales := 0;
                "Purch Return" := 0;
                "Transfer Shipment" := 0;
                "Negative Adj" := 0;
                Consumption := 0;
                "Total Stk Out" := 0;
                "Closing Stock" := 0;
                AssOutput := 0;

                ItemLedger.RESET;
                IF NOT RecItem.GET("Item No.") THEN BEGIN

                END ELSE
                    ItemDesc := RecItem.Description + ' ' + RecItem."Description 2";

                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Posting Date", 0D, Sdate - 1);
                ItemLedger.SETRANGE("Location Code", "Location Code");
                IF ItemLedger.FINDFIRST THEN BEGIN
                    ItemLedger.CALCSUMS(Quantity);
                    "Opening Stock" := ItemLedger.Quantity;
                END;

                ItemLedger.RESET;
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::Purchase);
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");
                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        IF ItemLedger.Quantity > 0 THEN
                            PurchasesInc += ItemLedger.Quantity
                        ELSE
                            "Purch Return" += ItemLedger.Quantity;
                    UNTIL ItemLedger.NEXT = 0
                END;

                //Calc Sales
                ItemLedger.RESET;
                //sash
                //ItemLedger.SETCURRENTKEY("Posting Date","Item No.","Location Code","Global Dimension 1 Code");
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::Sale);
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        IF ItemLedger.Quantity > 0 THEN
                            "Sales Return" += ItemLedger.Quantity
                        ELSE
                            Sales += ItemLedger.Quantity;
                    UNTIL ItemLedger.NEXT = 0;
                    ItemLedger.RESET;
                END;

                //Calc Adj.
                ItemLedger.RESET;
                //sash
                //ItemLedger.SETCURRENTKEY("Posting Date","Item No.","Location Code","Global Dimension 1 Code");
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::"Negative Adjmt.");
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        IF ItemLedger.Quantity > 0 THEN
                            "Positive Adj" += ItemLedger.Quantity
                        ELSE
                            "Negative Adj" += ItemLedger.Quantity;
                    UNTIL ItemLedger.NEXT = 0

                END;

                //Calc Adj.
                ItemLedger.RESET;
                //sash
                //ItemLedger.SETCURRENTKEY("Posting Date","Item No.","Location Code","Global Dimension 1 Code");
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::"Positive Adjmt.");
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        IF ItemLedger.Quantity > 0 THEN
                            "Positive Adj" += ItemLedger.Quantity
                        ELSE
                            "Negative Adj" += ItemLedger.Quantity;
                    UNTIL ItemLedger.NEXT = 0

                END;


                //Calc Trans.
                ItemLedger.RESET;
                //sash
                //ItemLedger.SETCURRENTKEY("Posting Date","Item No.","Location Code","Global Dimension 1 Code");
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::Transfer);
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        IF ItemLedger.Quantity > 0 THEN
                            "Transfer Receipt" += ItemLedger.Quantity
                        ELSE
                            "Transfer Shipment" += ItemLedger.Quantity;
                    UNTIL ItemLedger.NEXT = 0;
                    ItemLedger.RESET;
                END;


                //AlleND02
                //Consumption
                ItemLedger.RESET;
                //sash
                //ItemLedger.SETCURRENTKEY("Posting Date","Item No.","Location Code","Global Dimension 1 Code");
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::Consumption);
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        Consumption += ItemLedger.Quantity
                    UNTIL ItemLedger.NEXT = 0;
                    ItemLedger.RESET;
                END;

                //Output
                ItemLedger.RESET;
                //sash
                //ItemLedger.SETCURRENTKEY("Posting Date","Item No.","Location Code","Global Dimension 1 Code");
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::Output);
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        Output += ItemLedger.Quantity
                    UNTIL ItemLedger.NEXT = 0;
                    ItemLedger.RESET;
                END;
                //AlleND02

                //Assembly Output Rk301221>>>
                ItemLedger.RESET;
                ItemLedger.SETCURRENTKEY("Location Code", "Posting Date", "Document No.", "Item No.");
                ItemLedger.SETRANGE("Item No.", "Item No.");
                ItemLedger.SETRANGE("Entry Type", ItemLedger."Entry Type"::"Assembly Output");
                ItemLedger.SETRANGE("Posting Date", Sdate, Edate);
                ItemLedger.SETRANGE("Location Code", "Location Code");
                ItemLedger.SETFILTER("Item Category Code", '%1', 'SAMPLE');

                IF ItemLedger.FINDSET THEN BEGIN
                    REPEAT
                        AssOutput += ItemLedger.Quantity
                    UNTIL ItemLedger.NEXT = 0;
                    ItemLedger.RESET;
                END;
                //Rk301221<<<<

                "Total Stk In" := PurchasesInc + "Sales Return" + "Transfer Receipt" + "Positive Adj" + Output + AssOutput;
                "Total Stk Out" := "Total Stk Out" + Sales + "Purch Return" + "Transfer Shipment" + "Negative Adj" + Consumption;
                "Closing Stock" := "Opening Stock" + "Total Stk In" + "Total Stk Out";

                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETCURRENTKEY("Item No.");
                ItemUnitofMeasure.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                ItemUnitofMeasure.SETFILTER(ItemUnitofMeasure.Code, '%1', 'CRT');
                IF ItemUnitofMeasure.FINDFIRST THEN BEGIN
                    ClosingCRT := ("Closing Stock" / ItemUnitofMeasure."Qty. per Unit of Measure");
                END;

                /*IF ("Total Stk In"=0) AND ("Total Stk Out"=0) AND ("Closing Stock"=0) THEN //Alle RDB 290107
                   CurrReport.SKIP;  //Alle RDB 290107

                IF ("Opening Stock"=0) AND ("Closing Stock"=0)THEN
                  CurrReport.SKIP;
                 */


                /*SubTransRecpt+="Transfer Receipt";
                SubOpnQty+="Opening Stock";
                SubPur+=PurchasesInc;
                SubOutPutt+=Output;
                SubConsumpQty+=Consumption;
                //SubAdjustment+=Adjustment;
                SubPosAdj+="Positive Adj";
                SubNegAdj+="Negative Adj";
                SubTransShip+="Transfer Shipment";
                SubsaleQty+=Sales;
                SubPurReturn+="Purch Return";
                SubSaleReturn+="Sales Return";
                SubTotStockIn+="Total Stk In";
                 SubTotStockOut+="Total Stk Out";
                SubClosingQty+="Closing Stock";
                  */




                /*
                //ALLE MA 191206 >>
                IF NOT ShowAllItem THEN BEGIN
                  IF ShowItemWithTrans THEN BEGIN
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE("Item No.", "No.");
                    ItemLedgerEntry.SETFILTER("Posting Date", DateFilter);//Alle RDB 151206
                    //sash //ItemLedgerEntry.SETFILTER("Manufacturer Code", ManuCodeFilter);//Alle RDB 090407
                       ItemLedgerEntry.SETFILTER("Location Code", GETFILTER("Location Filter"));//Alle RDB090407
                    IF NOT ItemLedgerEntry.FIND('-') THEN
                      CurrReport.SKIP;
                    IF ("Total Stk In"=0) AND ("Total Stk Out"=0) AND ("Closing Stock"=0) THEN //Alle RDB 290107
                      CurrReport.SKIP;  //Alle RDB 290107
                  END ELSE BEGIN
                   IF ("Opening Stock"=0) AND ("Closing Stock"=0)THEN
                     CurrReport.SKIP;
                  END;
                END;
                //ALLE MA 191206 <<
                      */
                IF Location.GET("Location Code") THEN
                    locname := Location.Name;

            end;

            trigger OnPreDataItem()
            begin
                //ERROR('%1 = %2',Sdate,Edate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; Sdate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; Edate)
                {
                    ApplicationArea = All;
                }
                field(Summary; summery)
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        "Opening Stock": Decimal;
        PurchasesInc: Decimal;
        "Sales Return": Decimal;
        "Transfer Receipt": Decimal;
        "Positive Adj": Decimal;
        "Total Stk In": Decimal;
        Sales: Decimal;
        "Purch Return": Decimal;
        "Transfer Shipment": Decimal;
        ILE: Record "Item Ledger Entry";
        ItemDesc: Text[100];
        "Negative Adj": Decimal;
        "Total Stk Out": Decimal;
        "Closing Stock": Decimal;
        ItemLedger: Record "Item Ledger Entry";
        RecILE: Record "Item Ledger Entry";
        ShowAllItem: Boolean;
        Consumption: Decimal;
        Output: Decimal;
        ShowItemWithTrans: Boolean;
        ItemLedgerEntry: Record "Item Ledger Entry";
        DateFilter: Text[30];
        ManuCodeFilter: Text[30];
        GtrsfOPutQty: Decimal;
        RecItem: Record Item;
        Descrip: Text[60];
        OpnQty: Decimal;
        Pur: Decimal;
        Pos: Decimal;
        OutPutt: Decimal;
        Adjustment: Decimal;
        SaleQty: Decimal;
        ConsumpQty: Decimal;
        TransRecpt: Decimal;
        TransShip: Decimal;
        ClosingQty: Decimal;
        Sdate: Date;
        Edate: Date;
        Neg: Decimal;
        ValueEntry: Record "Value Entry";
        ExcelBuff: Record "Excel Buffer" temporary;
        I: Integer;
        ExportToExcel: Boolean;
        summery: Boolean;
        SubClosingQty: Decimal;
        GrandClosingQty: Decimal;
        SubTransRecpt: Decimal;
        SubOpnQty: Decimal;
        SubTransShip: Decimal;
        SubPur: Decimal;
        SubOutPutt: Decimal;
        SubAdjustment: Decimal;
        SubsaleQty: Decimal;
        SubConsumpQty: Decimal;
        Granttotal: Integer;
        Gopnqty: Decimal;
        GPur: Decimal;
        Goutputt: Decimal;
        GTransrept: Decimal;
        GTranship: Decimal;
        GAdjustment: Decimal;
        GConsupqty: Decimal;
        GSaleQty: Decimal;
        LocDes: Text[100];
        ItemTableFilter: Text[150];
        SubSaleReturn: Decimal;
        SubPosAdj: Decimal;
        SubTotStockIn: Decimal;
        SubPurReturn: Decimal;
        SubNegAdj: Decimal;
        SubTotStockOut: Decimal;
        GrSaleReturn: Decimal;
        GrPosAdj: Decimal;
        GrTotStockIn: Decimal;
        GrPurReturn: Decimal;
        GrNegAdj: Decimal;
        GrTotStockOut: Decimal;
        ItemLocFilter: Text[150];
        ItemUnitFilter: Text[30];
        ItemCategoryFilter: Text[100];
        PrevItemNo: Code[50];
        LOC: Text[30];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        PrevLoc: Code[20];
        Location: Record Location;
        locname: Text[100];
        blnAdmin: Boolean;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        ClosingCRT: Decimal;
        AssOutput: Decimal;
}

